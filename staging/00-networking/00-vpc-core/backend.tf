terraform {
  backend "s3" {
    bucket       = "agevegacom-terraform-state"
    key          = "staging/00-networking/00-vpc-core/terraform.tfstate"
    profile      = "terraform"
    region       = "eu-south-2"
    use_lockfile = true
  }
}
