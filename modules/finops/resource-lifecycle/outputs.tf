output "automation_account_id" {
  description = "Automation account ID"
  value       = azurerm_automation_account.this.id
}

output "automation_account_name" {
  description = "Automation account name"
  value       = azurerm_automation_account.this.name
}

output "automation_identity_principal_id" {
  description = "Automation account managed identity principal ID"
  value       = azurerm_automation_account.this.identity[0].principal_id
}

output "shutdown_runbook_id" {
  description = "Shutdown runbook ID"
  value       = var.enable_vm_auto_shutdown ? azurerm_automation_runbook.shutdown_vms[0].id : null
}

output "shutdown_schedule_id" {
  description = "Shutdown schedule ID"
  value       = var.enable_vm_auto_shutdown ? azurerm_automation_schedule.daily_shutdown[0].id : null
}