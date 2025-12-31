output "dns_zone_ids" {
  description = "Map of DNS zone names to IDs"
  value = {
    for name, zone in azurerm_private_dns_zone.this : name => zone.id
  }
}

output "dns_zone_names" {
  description = "List of created DNS zone names"
  value       = var.dns_zones
}

output "vnet_link_ids" {
  description = "Map of VNet link keys to IDs"
  value = {
    for key, link in azurerm_private_dns_zone_virtual_network_link.this : key => link.id
  }
}