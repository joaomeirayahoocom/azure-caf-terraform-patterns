output "diagnostic_setting_id" {
  description = "Diagnostic setting ID"
  value       = azurerm_monitor_diagnostic_setting.this.id
}

output "diagnostic_setting_name" {
  description = "Diagnostic setting name"
  value       = azurerm_monitor_diagnostic_setting.this.name
}

output "target_resource_id" {
  description = "Target resource ID"
  value       = var.target_resource_id
}