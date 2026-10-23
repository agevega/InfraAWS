# development

Entorno de desarrollo. Su código es una copia de [`sandbox`](../sandbox/), el padre común: este README solo recoge en qué se diferencia.

## Diferencias generales

| Valor                                                               | sandbox               | development          |
| ------------------------------------------------------------------- | --------------------- | -------------------- |
| `environment` (directorio, etiqueta `Environment` y keys del state) | `sandbox`             | `development`        |
| `environment_short` (nombres de los recursos)                       | `sand`                | `dev`                |
| Ejemplo de nombre                                                   | `agevegacom-sand-vpc` | `agevegacom-dev-vpc` |

## 00-networking

| Valor                       | sandbox                           | development                     |
| --------------------------- | --------------------------------- | ------------------------------- |
| CIDR de la VPC (`vpc_cidr`) | `10.250.0.0/16`                   | `10.30.0.0/16`                  |
| Subredes públicas           | `10.250.1.0/24` a `10.250.3.0/24` | `10.30.1.0/24` a `10.30.3.0/24` |
| Subredes privadas           | `10.250.4.0/24` a `10.250.6.0/24` | `10.30.4.0/24` a `10.30.6.0/24` |
| Subredes de base de datos   | `10.250.7.0/24` a `10.250.9.0/24` | `10.30.7.0/24` a `10.30.9.0/24` |

Recursos, variables, costes y despliegue: igual que en [sandbox/00-networking](../sandbox/00-networking/README.md), ejecutando los comandos desde `development/00-networking/`.
