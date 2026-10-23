variable "project_name" {
  description = "Project name"
  type        = string
  default     = "agevegacom"
}

variable "project_owner" {
  description = "Project owner"
  type        = string
  default     = "Alejandro Vega"
}

variable "aws_profile" {
  description = "AWS CLI Profile"
  type        = string
  default     = "terraform"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-south-2"
}

variable "domain_name" {
  description = "Domain name"
  type        = string
  default     = "agevega.com"
}
