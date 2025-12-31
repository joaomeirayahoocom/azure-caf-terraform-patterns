output "initiative_id" {
  description = "CAF baseline policy initiative ID"
  value       = azurerm_policy_set_definition.caf_baseline.id
}

output "assignment_id" {
  description = "CAF baseline policy assignment ID"
  value       = azurerm_management_group_policy_assignment.caf_baseline.id
}

output "initiative_name" {
  description = "CAF baseline policy initiative name"
  value       = azurerm_policy_set_definition.caf_baseline.name
}