locals {
  environment       = "sandbox"
  environment_short = "sand"
  name_prefix       = "${var.project_name}-${local.environment_short}"

  az_letters = [for az in var.availability_zones : substr(az, -1, 1)]
  azs        = zipmap(local.az_letters, var.availability_zones)

  public_subnets  = zipmap(local.az_letters, var.public_subnets)
  private_subnets = zipmap(local.az_letters, var.private_subnets)
  db_subnets      = zipmap(local.az_letters, var.db_subnets)

  common_tags = {
    Project     = var.project_name
    Owner       = var.project_owner
    ManagedBy   = "terraform"
    Environment = local.environment
    Module      = "00-networking/00-vpc-core"
  }
}
