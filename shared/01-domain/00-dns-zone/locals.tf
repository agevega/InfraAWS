locals {
  environment       = "shared"
  environment_short = "shared"
  name_prefix       = "${var.project_name}-${local.environment_short}"

  common_tags = {
    Project     = var.project_name
    Owner       = var.project_owner
    ManagedBy   = "terraform"
    Environment = local.environment
    Module      = "01-domain/00-dns-zone"
  }
}
