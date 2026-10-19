locals {
  state_bucket_name = "${var.project_name}-terraform-state"

  common_tags = {
    Project     = var.project_name
    Owner       = var.project_owner
    ManagedBy   = "terraform"
    Environment = "shared"
    Module      = "00-setup/00-tf-backend"
  }
}
