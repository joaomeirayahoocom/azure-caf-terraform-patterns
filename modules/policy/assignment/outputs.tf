output "assignment_id" {
  description = "Policy assignment ID"
  value       = azurerm_management_group_policy_assignment.this.id
}

output "assignment_name" {
  description = "Policy assignment name"
  value       = azurerm_management_group_policy_assignment.this.name
}

output "scope" {
  description = "Policy assignment scope"
  value       = var.scope
}