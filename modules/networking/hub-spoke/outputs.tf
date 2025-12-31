output "hub_vnet_id" {
  description = "Hub virtual network ID"
  value       = azurerm_virtual_network.hub.id
}

output "hub_vnet_name" {
  description = "Hub virtual network name"
  value       = azurerm_virtual_network.hub.name
}

output "hub_address_space" {
  description = "Hub virtual network address space"
  value       = azurerm_virtual_network.hub.address_space
}

output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value = {
    for name, subnet in azurerm_subnet.hub : name => subnet.id
  }
}

output "nsg_id" {
  description = "Hub network security group ID"
  value       = azurerm_network_security_group.hub.id
}