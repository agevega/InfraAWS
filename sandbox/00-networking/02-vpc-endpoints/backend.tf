terraform {
  backend "s3" {
    bucket       = "agevegacom-terraform-state"
    key          = "sandbox/00-networking/02-vpc-endpoints/terraform.tfstate"
    profile      = "terraform"
    region       = "eu-south-2"
    use_lockfile = true
  }
}
