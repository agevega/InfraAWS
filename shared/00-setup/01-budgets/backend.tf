terraform {
  backend "s3" {
    bucket       = "agevegacom-terraform-state"
    key          = "shared/00-setup/01-budgets/terraform.tfstate"
    region       = "eu-south-2"
    use_lockfile = true
    profile      = "terraform"
  }
}
