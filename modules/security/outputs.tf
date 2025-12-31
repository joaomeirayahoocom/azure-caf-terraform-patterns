output "key_vault_id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault.this.id
}

output "key_vault_name" {
  description = "Key Vault name"
  value       = azurerm_key_vault.this.name
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.this.vault_uri
}

output "key_vault_tenant_id" {
  description = "Key Vault tenant ID"
  value       = azurerm_key_vault.this.tenant_id
}

output "private_endpoint_ip" {
  description = "Private endpoint IP address"
  value       = var.private_endpoint_subnet_id != null ? azurerm_private_endpoint.this[0].private_service_connection[0].private_ip_address : null
}