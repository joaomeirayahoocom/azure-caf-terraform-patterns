resource "azurerm_management_group" "root" {
  display_name = var.root_display_name
  name         = var.root_id
}

# Platform Management Groups
resource "azurerm_management_group" "platform" {
  count = var.create_platform_mg ? 1 : 0

  display_name               = "Platform"
  name                       = "${var.root_id}-platform"
  parent_management_group_id = azurerm_management_group.root.id
}

resource "azurerm_management_group" "platform_identity" {
  count = var.create_platform_mg ? 1 : 0

  display_name               = "Identity"
  name                       = "${var.root_id}-platform-identity"
  parent_management_group_id = azurerm_management_group.platform[0].id
}

resource "azurerm_management_group" "platform_management" {
  count = var.create_platform_mg ? 1 : 0

  display_name               = "Management"
  name                       = "${var.root_id}-platform-management"
  parent_management_group_id = azurerm_management_group.platform[0].id
}

resource "azurerm_management_group" "platform_connectivity" {
  count = var.create_platform_mg ? 1 : 0

  display_name               = "Connectivity"
  name                       = "${var.root_id}-platform-connectivity"
  parent_management_group_id = azurerm_management_group.platform[0].id
}

# Landing Zones Management Groups
resource "azurerm_management_group" "landing_zones" {
  count = var.create_landing_zones_mg ? 1 : 0

  display_name               = "Landing Zones"
  name                       = "${var.root_id}-landing-zones"
  parent_management_group_id = azurerm_management_group.root.id
}

resource "azurerm_management_group" "landing_zones_prod" {
  count = var.create_landing_zones_mg ? 1 : 0

  display_name               = "Prod"
  name                       = "${var.root_id}-landing-zones-prod"
  parent_management_group_id = azurerm_management_group.landing_zones[0].id
}

resource "azurerm_management_group" "landing_zones_dev" {
  count = var.create_landing_zones_mg ? 1 : 0

  display_name               = "Dev"
  name                       = "${var.root_id}-landing-zones-dev"
  parent_management_group_id = azurerm_management_group.landing_zones[0].id
}

# Decommissioned Management Group
resource "azurerm_management_group" "decommissioned" {
  count = var.create_decommissioned_mg ? 1 : 0

  display_name               = "Decommissioned"
  name                       = "${var.root_id}-decommissioned"
  parent_management_group_id = azurerm_management_group.root.id
}