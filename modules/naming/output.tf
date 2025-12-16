output "base_name" {
  description = "Base naming pattern for resources"
  value       = local.base_name
}

output "names" {
  description = "Map of resource type to generated name"
  value       = local.names
}

output "unique_names" {
  description = "Map of globally unique resource names"
  value       = local.unique_names
}

output "resource_group" {
  description = "Resource group name"
  value       = local.names.resource_group
}

output "virtual_network" {
  description = "Virtual network name"
  value       = local.names.virtual_network
}

output "storage_account" {
  description = "Storage account name (globally unique)"
  value       = local.unique_names.storage_account
}

output "key_vault" {
  description = "Key Vault name (globally unique)"
  value       = local.unique_names.key_vault
}

output "app_service" {
  description = "App Service name (globally unique)"
  value       = local.unique_names.app_service
}

output "app_service_plan" {
  description = "App Service Plan name"
  value       = local.names.app_service_plan
}

output "tags" {
  description = "Standard tags to apply to all resources"
  value = {
    Environment    = var.environment
    Workload       = var.workload
    ManagedBy      = "Terraform"
    Organization   = var.org_prefix
    CostCenter     = var.cost_center
    Owner          = var.owner
    DataClass      = var.data_classification
    CarbonTracking = "enabled"
  }
}