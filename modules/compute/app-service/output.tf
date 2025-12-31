output "app_service_plan_id" {
  description = "App Service Plan ID"
  value       = azurerm_service_plan.this.id
}

output "app_service_plan_name" {
  description = "App Service Plan name"
  value       = azurerm_service_plan.this.name
}

output "app_service_id" {
  description = "App Service ID"
  value       = var.os_type == "Linux" ? azurerm_linux_web_app.this[0].id : azurerm_windows_web_app.this[0].id
}

output "app_service_name" {
  description = "App Service name"
  value       = var.app_service_name
}

output "default_hostname" {
  description = "Default hostname of the App Service"
  value       = var.os_type == "Linux" ? azurerm_linux_web_app.this[0].default_hostname : azurerm_windows_web_app.this[0].default_hostname
}

output "identity_principal_id" {
  description = "System-assigned managed identity principal ID"
  value       = var.os_type == "Linux" ? azurerm_linux_web_app.this[0].identity[0].principal_id : azurerm_windows_web_app.this[0].identity[0].principal_id
}

output "private_endpoint_ip" {
  description = "Private endpoint IP address"
  value       = var.private_endpoint_subnet_id != null ? azurerm_private_endpoint.this[0].private_service_connection[0].private_ip_address : null
}