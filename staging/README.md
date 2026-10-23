# staging

Entorno de preproducción: réplica de producción para validar los cambios antes de llevarlos a pro. Su código es una copia de [`sandbox`](../sandbox/), el padre común: este README solo recoge en qué se diferencia.

## Diferencias generales

| Valor                                                               | sandbox               | staging              |
| ------------------------------------------------------------------- | --------------------- | -------------------- |
| `environment` (directorio, etiqueta `Environment` y keys del state) | `sandbox`             | `staging`            |
| `environment_short` (nombres de los recursos)                       | `sand`                | `pre`                |
| Ejemplo de nombre                                                   | `agevegacom-sand-vpc` | `agevegacom-pre-vpc` |

## 00-networking

| Valor                       | sandbox                           | staging                         |
| --------------------------- | --------------------------------- | ------------------------------- |
| CIDR de la VPC (`vpc_cidr`) | `10.250.0.0/16`                   | `10.20.0.0/16`                  |
| Subredes públicas           | `10.250.1.0/24` a `10.250.3.0/24` | `10.20.1.0/24` a `10.20.3.0/24` |
| Subredes privadas           | `10.250.4.0/24` a `10.250.6.0/24` | `10.20.4.0/24` a `10.20.6.0/24` |
| Subredes de base de datos   | `10.250.7.0/24` a `10.250.9.0/24` | `10.20.7.0/24` a `10.20.9.0/24` |

Recursos, variables, costes y despliegue: igual que en [sandbox/00-networking](../sandbox/README.md), ejecutando los comandos desde `staging/00-networking/`.
