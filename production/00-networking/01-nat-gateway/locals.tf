locals {
  environment       = "production"
  environment_short = "pro"
  name_prefix       = "${var.project_name}-${local.environment_short}"

  state_bucket_name  = "${var.project_name}-terraform-state"
  vpc_core_state_key = "${local.environment}/00-networking/00-vpc-core/terraform.tfstate"

  common_tags = {
    Project     = var.project_name
    Owner       = var.project_owner
    ManagedBy   = "terraform"
    Environment = local.environment
    Module      = "00-networking/01-nat-gateway"
  }
}
