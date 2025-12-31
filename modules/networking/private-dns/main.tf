resource "azurerm_private_dns_zone" "this" {
  for_each = toset(var.dns_zones)

  name                = each.value
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = {
    for pair in flatten([
      for zone in var.dns_zones : [
        for vnet_name, vnet in var.vnet_links : {
          key                  = "${zone}-${vnet_name}"
          zone_name            = zone
          vnet_name            = vnet_name
          vnet_id              = vnet.vnet_id
          registration_enabled = vnet.registration_enabled
        }
      ]
    ]) : pair.key => pair
  }

  name                  = each.value.vnet_name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this[each.value.zone_name].name
  virtual_network_id    = each.value.vnet_id
  registration_enabled  = each.value.registration_enabled
  tags                  = var.tags
}