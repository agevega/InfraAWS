locals {
  monthly_budget_name = "${var.project_name}-monthly-budget"
  daily_budget_name   = "${var.project_name}-daily-budget"

  common_tags = {
    Project     = var.project_name
    Owner       = var.project_owner
    ManagedBy   = "terraform"
    Environment = "shared"
    Module      = "00-setup/01-budgets"
  }
}
