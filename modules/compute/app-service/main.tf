resource "azurerm_service_plan" "this" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_linux_web_app" "this" {
  count = var.os_type == "Linux" ? 1 : 0

  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = var.https_only
  tags                = var.tags

  site_config {
    always_on = var.sku_name != "F1" && var.sku_name != "B1" ? true : false

    application_stack {
      dotnet_version = var.dotnet_version
      node_version   = var.node_version
      python_version = var.python_version
    }
  }

  app_settings = var.app_settings

  dynamic "identity" {
    for_each = [1]
    content {
      type = "SystemAssigned"
    }
  }
}

resource "azurerm_windows_web_app" "this" {
  count = var.os_type == "Windows" ? 1 : 0

  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = var.https_only
  tags                = var.tags

  site_config {
    always_on = var.sku_name != "F1" && var.sku_name != "B1" ? true : false

    application_stack {
      dotnet_version = var.dotnet_version
      node_version   = var.node_version
    }
  }

  app_settings = var.app_settings

  dynamic "identity" {
    for_each = [1]
    content {
      type = "SystemAssigned"
    }
  }
}

# VNet Integration (optional)
resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  count = var.subnet_id != null ? 1 : 0

  app_service_id = var.os_type == "Linux" ? azurerm_linux_web_app.this[0].id : azurerm_windows_web_app.this[0].id
  subnet_id      = var.subnet_id
}

# Private Endpoint (optional)
resource "azurerm_private_endpoint" "this" {
  count = var.private_endpoint_subnet_id != null ? 1 : 0

  name                = "${var.app_service_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "${var.app_service_name}-psc"
    private_connection_resource_id = var.os_type == "Linux" ? azurerm_linux_web_app.this[0].id : azurerm_windows_web_app.this[0].id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}