# production

Entorno de producción. Su código es una copia de [`sandbox`](../sandbox/), el padre común: este README solo recoge en qué se diferencia.

## Diferencias generales

| Valor                                                               | sandbox               | production           |
| ------------------------------------------------------------------- | --------------------- | -------------------- |
| `environment` (directorio, etiqueta `Environment` y keys del state) | `sandbox`             | `production`         |
| `environment_short` (nombres de los recursos)                       | `sand`                | `pro`                |
| Ejemplo de nombre                                                   | `agevegacom-sand-vpc` | `agevegacom-pro-vpc` |

## 00-networking

| Valor                       | sandbox                           | production                      |
| --------------------------- | --------------------------------- | ------------------------------- |
| CIDR de la VPC (`vpc_cidr`) | `10.250.0.0/16`                   | `10.10.0.0/16`                  |
| Subredes públicas           | `10.250.1.0/24` a `10.250.3.0/24` | `10.10.1.0/24` a `10.10.3.0/24` |
| Subredes privadas           | `10.250.4.0/24` a `10.250.6.0/24` | `10.10.4.0/24` a `10.10.6.0/24` |
| Subredes de base de datos   | `10.250.7.0/24` a `10.250.9.0/24` | `10.10.7.0/24` a `10.10.9.0/24` |

Recursos, variables, costes y despliegue: igual que en [sandbox/00-networking](../sandbox/README.md), ejecutando los comandos desde `production/00-networking/`.
