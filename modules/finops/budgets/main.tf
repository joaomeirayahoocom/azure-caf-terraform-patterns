locals {
  start_date = var.start_date != null ? var.start_date : formatdate("YYYY-MM-01", timestamp())
}

resource "azurerm_consumption_budget_subscription" "this" {
  count = length(regexall("subscriptions", var.scope)) > 0 ? 1 : 0

  name            = var.budget_name
  subscription_id = var.scope
  amount          = var.amount
  time_grain      = var.time_grain

  time_period {
    start_date = "${local.start_date}T00:00:00Z"
  }

  dynamic "notification" {
    for_each = var.alert_thresholds
    content {
      enabled        = true
      threshold      = notification.value
      operator       = "GreaterThan"
      threshold_type = notification.value < 100 ? "Actual" : "Forecasted"
      contact_emails = var.alert_emails
    }
  }

  lifecycle {
    ignore_changes = [time_period]
  }
}

resource "azurerm_consumption_budget_resource_group" "this" {
  count = length(regexall("resourceGroups", var.scope)) > 0 ? 1 : 0

  name              = var.budget_name
  resource_group_id = var.scope
  amount            = var.amount
  time_grain        = var.time_grain

  time_period {
    start_date = "${local.start_date}T00:00:00Z"
  }

  dynamic "notification" {
    for_each = var.alert_thresholds
    content {
      enabled        = true
      threshold      = notification.value
      operator       = "GreaterThan"
      threshold_type = notification.value < 100 ? "Actual" : "Forecasted"
      contact_emails = var.alert_emails
    }
  }

  lifecycle {
    ignore_changes = [time_period]
  }
}