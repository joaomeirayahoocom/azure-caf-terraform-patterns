output "initiative_id" {
  description = "Net Zero policy initiative ID"
  value       = azurerm_policy_set_definition.net_zero.id
}

output "assignment_id" {
  description = "Net Zero policy assignment ID"
  value       = azurerm_management_group_policy_assignment.net_zero.id
}

output "carbon_tag_policy_id" {
  description = "Carbon tracking tag policy ID"
  value       = azurerm_policy_definition.require_carbon_tag.id
}

output "oversized_vm_policy_id" {
  description = "Oversized VM audit policy ID"
  value       = azurerm_policy_definition.audit_oversized_vms.id
}

output "allowed_regions" {
  description = "Allowed low-carbon regions"
  value       = var.allowed_regions
}