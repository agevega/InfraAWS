terraform {
  backend "s3" {
    bucket       = "agevegacom-terraform-state"
    key          = "shared/01-domain/00-dns-zone/terraform.tfstate"
    profile      = "terraform"
    region       = "eu-south-2"
    use_lockfile = true
  }
}
