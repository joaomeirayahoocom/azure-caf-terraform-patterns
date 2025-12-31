output "spoke_vnet_id" {
  description = "Spoke virtual network ID"
  value       = azurerm_virtual_network.spoke.id
}

output "spoke_vnet_name" {
  description = "Spoke virtual network name"
  value       = azurerm_virtual_network.spoke.name
}

output "spoke_address_space" {
  description = "Spoke virtual network address space"
  value       = azurerm_virtual_network.spoke.address_space
}

output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value = {
    for name, subnet in azurerm_subnet.spoke : name => subnet.id
  }
}

output "nsg_id" {
  description = "Spoke network security group ID"
  value       = azurerm_network_security_group.spoke.id
}

output "peering_id" {
  description = "Spoke to hub peering ID"
  value       = azurerm_virtual_network_peering.spoke_to_hub.id
}