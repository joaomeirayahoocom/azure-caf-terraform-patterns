output "root_mg_id" {
  description = "Root management group ID"
  value       = azurerm_management_group.root.id
}

output "platform_mg_id" {
  description = "Platform management group ID"
  value       = var.create_platform_mg ? azurerm_management_group.platform[0].id : null
}

output "platform_identity_mg_id" {
  description = "Platform Identity management group ID"
  value       = var.create_platform_mg ? azurerm_management_group.platform_identity[0].id : null
}

output "platform_management_mg_id" {
  description = "Platform Management management group ID"
  value       = var.create_platform_mg ? azurerm_management_group.platform_management[0].id : null
}

output "platform_connectivity_mg_id" {
  description = "Platform Connectivity management group ID"
  value       = var.create_platform_mg ? azurerm_management_group.platform_connectivity[0].id : null
}

output "landing_zones_mg_id" {
  description = "Landing Zones management group ID"
  value       = var.create_landing_zones_mg ? azurerm_management_group.landing_zones[0].id : null
}

output "landing_zones_prod_mg_id" {
  description = "Landing Zones Prod management group ID"
  value       = var.create_landing_zones_mg ? azurerm_management_group.landing_zones_prod[0].id : null
}

output "landing_zones_dev_mg_id" {
  description = "Landing Zones Dev management group ID"
  value       = var.create_landing_zones_mg ? azurerm_management_group.landing_zones_dev[0].id : null
}

output "decommissioned_mg_id" {
  description = "Decommissioned management group ID"
  value       = var.create_decommissioned_mg ? azurerm_management_group.decommissioned[0].id : null
}

output "hierarchy" {
  description = "Visual representation of the hierarchy"
  value = <<-EOT
    ${var.root_display_name} (${var.root_id})
    ├── Platform
    │   ├── Identity
    │   ├── Management
    │   └── Connectivity
    ├── Landing Zones
    │   ├── Prod
    │   └── Dev
    └── Decommissioned
  EOT
}