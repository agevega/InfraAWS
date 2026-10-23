terraform {
  backend "s3" {
    bucket       = "agevegacom-terraform-state"
    key          = "development/00-networking/01-nat-gateway/terraform.tfstate"
    profile      = "terraform"
    region       = "eu-south-2"
    use_lockfile = true
  }
}
