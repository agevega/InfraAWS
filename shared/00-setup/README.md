# 00-setup

Módulos base. Se aplican una sola vez por cuenta de AWS, en orden numérico, antes que cualquier otro módulo.

| Módulo | Para qué sirve |
|---|---|
| [00-tf-backend](00-tf-backend/) | Bucket S3 que guarda el state de Terraform de todos los módulos |

## Requisitos

- Terraform `~> 1.16`
- AWS CLI `>= 2.32` (para `aws login`)
- Región `eu-south-2` activada en la cuenta (viene desactivada por defecto)
- Credenciales: `aws login --profile terraform`

## 00-tf-backend

### Recursos

| Recurso | Para qué sirve |
|---|---|
| `aws_s3_bucket` | Guarda los ficheros de state. `prevent_destroy` impide borrarlo por accidente. |
| `aws_s3_bucket_versioning` | Conserva las versiones anteriores de cada state, para recuperarse de un apply erróneo o de un state corrupto. |
| `aws_s3_bucket_lifecycle_configuration` | Borra las versiones antiguas a los 365 días, conservando siempre las 10 más recientes. Limpia las subidas incompletas a los 7 días. |
| `aws_s3_bucket_public_access_block` | Bloquea cualquier acceso público. Los states pueden contener secretos. |
| `aws_s3_bucket_policy` | Rechaza cualquier petición que no use HTTPS. |

El cifrado (SSE-S3) y las ACLs desactivadas ya vienen así por defecto en AWS, por eso no se declaran. El bloqueo del state usa el lock nativo de Terraform en S3 (`use_lockfile`), sin DynamoDB.

Coste: céntimos al mes; solo se guardan unos KB de state y sus versiones.

### Variables

| Variable | Para qué sirve | Valor por defecto |
|---|---|---|
| `aws_region` | Región de despliegue | `eu-south-2` (España) |
| `aws_profile` | Perfil de AWS CLI con el que se ejecuta Terraform | `terraform` |
| `project_name` | Nombre del proyecto. De él salen el bucket (`<project_name>-terraform-state`) y la tag `Project` | `agevegacom` |
| `project_owner` | Tag `Owner` | `Alejandro Vega` |

### Bootstrap (solo la primera vez)

El bucket no puede guardar su propio state antes de existir, así que el backend de `backend.tf` empieza comentado. Desde `shared/00-setup/`:

```bash
cd 00-tf-backend
terraform init
terraform apply
# Descomentar el bloque terraform de backend.tf
terraform init -migrate-state   # responder yes
terraform state list            # debe mostrar los recursos
rm terraform.tfstate terraform.tfstate.backup
git add .terraform.lock.hcl     # y commitear
```

### Usar el backend desde otros módulos

Cada módulo añade este `backend.tf`, con `key` igual a su ruta en el repo:

```hcl
terraform {
  backend "s3" {
    bucket       = "agevegacom-terraform-state"
    key          = "<env>/<NN-group>/<NN-module>/terraform.tfstate"
    region       = "eu-south-2"
    use_lockfile = true
    profile      = "terraform"
  }
}
```

### Fork para otro proyecto o cuenta

Cambiar las variables de la tabla y, en todos los `backend.tf`, el `bucket` (y el `profile` si cambia), porque los bloques backend no admiten variables. Después, comentar aquí el bloque backend y seguir el bootstrap.
