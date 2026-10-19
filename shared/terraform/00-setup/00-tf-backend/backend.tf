# USAGE INSTRUCTIONS:
# 0. Credentials:
#    'aws login --profile terraform'.
# 1. Run 'terraform apply' first to create the bucket.
# 2. Once created, UNCOMMENT the 'terraform' block below.
# 3. Run 'terraform init -migrate-state' and type 'yes'.

# terraform {
#   backend "s3" {
#     bucket       = "agevegacom-terraform-state"
#     key          = "shared/terraform/00-setup/00-tf-backend/terraform.tfstate"
#     region       = "eu-south-2"
#     use_lockfile = true
#     profile      = "terraform"
#   }
# }
