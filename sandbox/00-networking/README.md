# 00-networking

Red del entorno, separada en submódulos para desplegar o destruir cada pieza por separado. `00-vpc-core` va siempre primero; el resto depende solo de él y puede desplegarse o destruirse cuando haga falta. Para destruir el core, destruye antes el resto.

| Módulo | Para qué sirve |
|---|---|
| [00-vpc-core](00-vpc-core/) | VPC, subredes, tablas de rutas e Internet Gateway |

Este código se desarrolla en `sandbox` y se copia tal cual a `dev`, `pre` y `pro`. Los entornos deben ser lo más idénticos posible.

## Plan de direccionamiento

Cada entorno tiene su propio `/16`, sin solaparse, para poder conectarlos entre sí si algún día hiciera falta. Cuanto más cerca de 0, más crítico es el entorno:

| Entorno | CIDR |
|---|---|
| shared | `10.0.0.0/16` (reservado, sin VPC) |
| pro | `10.10.0.0/16` |
| pre | `10.20.0.0/16` |
| dev | `10.30.0.0/16` |
| sandbox | `10.250.0.0/16` |

Cada entorno tiene libres los 9 bloques siguientes (por ejemplo, de `10.11` a `10.19` para pro) por si necesita crecer.

## 00-vpc-core

### Recursos

| Recurso | Para qué sirve |
|---|---|
| `aws_vpc` | Red privada del entorno, con DNS interno activado. |
| `aws_internet_gateway` | Conecta la VPC con internet. |
| `aws_default_security_group` | Vacía el security group por defecto: lo que acabe en él por error no tiene acceso a nada. |
| `aws_subnet` | 9 subredes: una por zona (`a`, `b`, `c`) y capa. |
| `aws_route_table` + `aws_route` | Una tabla pública con salida al Internet Gateway, y una tabla por zona para la capa privada y la de base de datos. |
| `aws_route_table_association` | Asocia cada subred a su tabla de rutas. |

### Capas

| Capa | Para qué | Subredes en sandbox | Salida a internet |
|---|---|---|---|
| Pública | Lo que debe ser accesible desde internet: balanceadores, NAT | `10.250.1.0/24` a `10.250.3.0/24` | Por el Internet Gateway. Las instancias reciben IP pública automáticamente. |
| Privada | Aplicaciones y servidores | `10.250.4.0/24` a `10.250.6.0/24` | Por el NAT, cuando `01-nat-gateway` está desplegado. |
| Base de datos | Bases de datos (RDS) | `10.250.7.0/24` a `10.250.9.0/24` | Ninguna. |

> **Coste: gratis.** La VPC, las subredes, las tablas de rutas y el Internet Gateway no tienen coste.

### Variables

Además de las [variables comunes](../../shared/00-setup/README.md#variables-comunes):

| Variable | Para qué sirve | Valor por defecto |
|---|---|---|
| `availability_zones` | Zonas en las que se reparten las subredes | `eu-south-2a`, `eu-south-2b`, `eu-south-2c` |
| `vpc_cidr` | CIDR de la VPC | `10.250.0.0/16` |
| `public_subnets` | CIDR de las subredes públicas, una por zona y en el mismo orden | `10.250.1.0/24`, `10.250.2.0/24`, `10.250.3.0/24` |
| `private_subnets` | CIDR de las subredes privadas | `10.250.4.0/24`, `10.250.5.0/24`, `10.250.6.0/24` |
| `db_subnets` | CIDR de las subredes de base de datos | `10.250.7.0/24`, `10.250.8.0/24`, `10.250.9.0/24` |

### Outputs

Cada subred y cada tabla de rutas tiene un output por zona (`public_subnet_a_id`, `private_route_table_b_id`…) y otro con las tres juntas (`public_subnet_ids`, `private_route_table_ids`…, con la forma `{ a, b, c }`). Además: `vpc_id`, `vpc_cidr`, `igw_id` y `public_route_table_id`.

### Despliegue

Desde `sandbox/00-networking/`:

```bash
cd 00-vpc-core
terraform init
terraform apply
```

Incluye `.terraform.lock.hcl` en el commit.

## Copiar a otro entorno

1. Copia `sandbox/00-networking` a `<entorno>/00-networking`.
2. En cada módulo, cambia `local.environment` en `locals.tf` y la `key` en `backend.tf`.
3. En `00-vpc-core`, ajusta `vpc_cidr` y las subredes según el plan de direccionamiento.
