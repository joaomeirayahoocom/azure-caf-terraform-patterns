output "identity_id" {
  description = "User-assigned managed identity ID"
  value       = azurerm_user_assigned_identity.this.id
}

output "identity_name" {
  description = "User-assigned managed identity name"
  value       = azurerm_user_assigned_identity.this.name
}

output "principal_id" {
  description = "Principal ID of the managed identity"
  value       = azurerm_user_assigned_identity.this.principal_id
}

output "client_id" {
  description = "Client ID of the managed identity"
  value       = azurerm_user_assigned_identity.this.client_id
}

output "tenant_id" {
  description = "Tenant ID of the managed identity"
  value       = azurerm_user_assigned_identity.this.tenant_id
}