output "subscription_id" {
  description = "The subscription ID"
  value       = var.subscription_id
}

output "subscription_name" {
  description = "The subscription display name"
  value       = var.subscription_name
}

output "management_group_id" {
  description = "The management group the subscription is placed under"
  value       = var.management_group_id
}

output "budget_id" {
  description = "The budget resource ID"
  value       = var.budget_amount > 0 && length(var.budget_alert_emails) > 0 ? azurerm_consumption_budget_subscription.this[0].id : null
}