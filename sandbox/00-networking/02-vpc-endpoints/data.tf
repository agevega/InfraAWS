data "terraform_remote_state" "vpc_core" {
  backend = "s3"

  config = {
    bucket  = local.state_bucket_name
    key     = local.vpc_core_state_key
    profile = var.aws_profile
    region  = var.aws_region
  }
}
