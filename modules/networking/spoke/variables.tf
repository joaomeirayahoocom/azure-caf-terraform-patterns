variable "resource_group_name" {
  description = "Resource group name for spoke network"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "spoke_vnet_name" {
  description = "Spoke virtual network name"
  type        = string
}

variable "spoke_address_space" {
  description = "Spoke VNet address space"
  type        = list(string)
}

variable "subnets" {
  description = "Spoke subnets configuration"
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "hub_vnet_id" {
  description = "Hub VNet ID for peering"
  type        = string
}

variable "hub_vnet_name" {
  description = "Hub VNet name for peering"
  type        = string
}

variable "hub_resource_group_name" {
  description = "Hub VNet resource group name"
  type        = string
}

variable "use_remote_gateways" {
  description = "Use hub VNet gateway for spoke traffic"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}