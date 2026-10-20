# 00-setup

Módulos base de la cuenta de AWS. Despliégalos en orden numérico antes que el resto.

| Módulo | Para qué sirve |
|---|---|
| [00-tf-backend](00-tf-backend/) | Bucket S3 que guarda el state de Terraform de todos los módulos |
| [01-budgets](01-budgets/) | Alertas por email cuando el gasto supera los presupuestos mensual y diario |

El **state** es el archivo con el que Terraform registra los recursos que gestiona. El **backend** indica dónde se guarda.

## Requisitos

- Terraform `~> 1.16`
- AWS CLI `>= 2.32` (para `aws login`)
- Región `eu-south-2` activada en la cuenta (viene desactivada por defecto)
- Credenciales: `aws login --profile terraform`

## Variables comunes

Ambos módulos usan estos valores por defecto:

| Variable | Para qué sirve | Valor por defecto |
|---|---|---|
| `project_name` | Nombre usado en los recursos y en la etiqueta `Project` | `agevegacom` |
| `project_owner` | Etiqueta `Owner` | `Alejandro Vega` |
| `aws_profile` | Perfil de AWS CLI con el que se ejecuta Terraform | `terraform` |
| `aws_region` | Región de despliegue | `eu-south-2` (España) |

## 00-tf-backend

### Recursos

| Recurso | Para qué sirve |
|---|---|
| `aws_s3_bucket` | Guarda los ficheros de state. `prevent_destroy` impide borrarlo por accidente. |
| `aws_s3_bucket_versioning` | Conserva versiones anteriores del state para poder recuperarlo. |
| `aws_s3_bucket_lifecycle_configuration` | Elimina versiones anteriores con más de 365 días, conservando las 10 más recientes de ellas. Limpia subidas incompletas a los 7 días. |
| `aws_s3_bucket_public_access_block` | Bloquea cualquier acceso público. Los states pueden contener secretos. |
| `aws_s3_bucket_policy` | Rechaza cualquier petición que no use HTTPS. |

El cifrado (SSE-S3) y las ACLs desactivadas ya vienen así por defecto en AWS, por eso no se declaran. El bloqueo del state usa el lock nativo de Terraform en S3 (`use_lockfile`), sin DynamoDB.

> **Coste: céntimos al mes.** Solo se guardan unos KB de state y sus versiones.

### Creación inicial (bootstrap)

El bucket debe existir antes de guardar el state en él. El backend ya está activo en el repo: **si el bucket ya existe, omite estos pasos** y usa `terraform init`.

1. Comenta el bloque `terraform` de `00-tf-backend/backend.tf` para empezar con un state local.
2. Crea el bucket desde `shared/00-setup/`:

   ```bash
   cd 00-tf-backend
   terraform init
   terraform apply
   ```

3. Descomenta el bloque y migra el state a S3:

   ```bash
   terraform init -migrate-state
   ```

   Responde `yes` cuando pida confirmar la copia.

4. Comprueba que aparecen los recursos con `terraform state list`. Solo tras confirmar la migración, elimina las copias locales:

   ```bash
   rm terraform.tfstate terraform.tfstate.backup
   ```

Incluye `.terraform.lock.hcl` en el commit para fijar las versiones de los proveedores.

### Usar el backend desde otros módulos

Añade este `backend.tf` a cada módulo. Sustituye `key` por su ruta en el repo seguida de `/terraform.tfstate`:

```hcl
terraform {
  backend "s3" {
    bucket       = "agevegacom-terraform-state"
    key          = "<env>/<NN-group>/<NN-module>/terraform.tfstate"
    profile      = "terraform"
    region       = "eu-south-2"
    use_lockfile = true
  }
}
```

## 01-budgets

### Alertas

Los umbrales son porcentajes del presupuesto correspondiente:

| Presupuesto | Gasto real | Previsión de gasto |
|---|---|---|
| Mensual | 10 %, 50 % y 100 % | 200 % del mes |
| Diario | 50 %, 100 %, 200 %, 500 % y 1000 % | — |

El diario detecta picos aunque el mensual ya haya avisado.

> **Coste: gratis.** Los presupuestos sin acciones no tienen coste.

### Variables

| Variable | Para qué sirve | Valor por defecto |
|---|---|---|
| `monthly_budget_amount` | Límite mensual en USD | `10.00` |
| `daily_budget_amount` | Límite diario en USD | `1.00` |
| `notification_email` | Email que recibe las alertas | `agevega@gmail.com` |

### Despliegue

Desde `shared/00-setup/`:

```bash
cd 01-budgets
terraform init
terraform apply
```

Incluye `.terraform.lock.hcl` en el commit.

## Adaptar a otro proyecto o cuenta

1. Ajusta las variables comunes en ambos módulos y `notification_email` en `01-budgets`.
2. Actualiza `bucket`, `region` y `profile` en todos los `backend.tf` según los nuevos valores. Los bloques backend no admiten variables.
3. Para una cuenta nueva, sigue la creación inicial del bucket y después despliega los presupuestos.
