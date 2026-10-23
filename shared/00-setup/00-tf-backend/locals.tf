locals {
  environment       = "shared"
  environment_short = "shared"
  name_prefix       = "${var.project_name}-${local.environment_short}"

  state_bucket_name = "${var.project_name}-terraform-state"

  common_tags = {
    Project     = var.project_name
    Owner       = var.project_owner
    ManagedBy   = "terraform"
    Environment = local.environment
    Module      = "00-setup/00-tf-backend"
  }
}
