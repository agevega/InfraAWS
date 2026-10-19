resource "aws_budgets_budget" "monthly" {
  name         = local.monthly_budget_name
  budget_type  = "COST"
  limit_amount = var.monthly_budget_amount
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  dynamic "notification" {
    for_each = [
      { threshold = 10, type = "ACTUAL" },
      { threshold = 50, type = "ACTUAL" },
      { threshold = 100, type = "ACTUAL" },
      { threshold = 200, type = "FORECASTED" },
    ]

    content {
      comparison_operator        = "GREATER_THAN"
      threshold                  = notification.value.threshold
      threshold_type             = "PERCENTAGE"
      notification_type          = notification.value.type
      subscriber_email_addresses = [var.notification_email]
    }
  }
}

resource "aws_budgets_budget" "daily" {
  name         = local.daily_budget_name
  budget_type  = "COST"
  limit_amount = var.daily_budget_amount
  limit_unit   = "USD"
  time_unit    = "DAILY"

  dynamic "notification" {
    for_each = [50, 100, 200, 500, 1000]

    content {
      comparison_operator        = "GREATER_THAN"
      threshold                  = notification.value
      threshold_type             = "PERCENTAGE"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = [var.notification_email]
    }
  }
}
