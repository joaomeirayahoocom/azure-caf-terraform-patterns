output "budget_id" {
  description = "Budget ID"
  value       = length(regexall("subscriptions", var.scope)) > 0 ? azurerm_consumption_budget_subscription.this[0].id : azurerm_consumption_budget_resource_group.this[0].id
}

output "budget_name" {
  description = "Budget name"
  value       = var.budget_name
}

output "budget_amount" {
  description = "Budget amount"
  value       = var.amount
}

output "alert_thresholds" {
  description = "Configured alert thresholds"
  value       = var.alert_thresholds
}