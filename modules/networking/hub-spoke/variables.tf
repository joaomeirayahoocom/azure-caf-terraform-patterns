variable "resource_group_name" {
  description = "Resource group name for hub network"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "hub_vnet_name" {
  description = "Hub virtual network name"
  type        = string
}

variable "hub_address_space" {
  description = "Hub VNet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "Hub subnets configuration"
  type = map(object({
    address_prefixes = list(string)
  }))
  default = {
    AzureFirewallSubnet = {
      address_prefixes = ["10.0.0.0/26"]
    }
    AzureBastionSubnet = {
      address_prefixes = ["10.0.0.64/26"]
    }
    GatewaySubnet = {
      address_prefixes = ["10.0.0.128/27"]
    }
  }
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "spoke_vnets" {
  description = "Map of spoke VNets to peer with hub"
  type = map(object({
    vnet_id = string
  }))
  default = {}
}

variable "enable_gateway_transit" {
  description = "Enable gateway transit for hub-spoke peering"
  type        = bool
  default     = false
}