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

variable "availability_zones" {
  description = "Availability zones used to spread the subnets"
  type        = list(string)
  default     = ["eu-south-2a", "eu-south-2b", "eu-south-2c"]
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnets" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
}

variable "private_subnets" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.20.4.0/24", "10.20.5.0/24", "10.20.6.0/24"]
}

variable "db_subnets" {
  description = "CIDR blocks for the database subnets"
  type        = list(string)
  default     = ["10.20.7.0/24", "10.20.8.0/24", "10.20.9.0/24"]
}
