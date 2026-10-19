variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-south-2"
}

variable "aws_profile" {
  description = "AWS CLI Profile"
  type        = string
  default     = "terraform"
}

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

variable "monthly_budget_amount" {
  description = "Monthly budget amount in USD"
  type        = number
  default     = 10.00
}

variable "daily_budget_amount" {
  description = "Daily budget amount in USD"
  type        = number
  default     = 1.00
}

variable "notification_email" {
  description = "Email address for budget notifications"
  type        = string
  default     = "agevega@gmail.com"
}
