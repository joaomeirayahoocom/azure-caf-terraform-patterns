variable "resource_group_name" {
  description = "Resource group name for DNS zones"
  type        = string
}

variable "dns_zones" {
  description = "List of private DNS zone names to create"
  type        = list(string)
  default = [
    "privatelink.blob.core.windows.net",
    "privatelink.file.core.windows.net",
    "privatelink.queue.core.windows.net",
    "privatelink.table.core.windows.net",
    "privatelink.vaultcore.azure.net",
    "privatelink.database.windows.net",
    "privatelink.azurecr.io",
    "privatelink.azurewebsites.net"
  ]
}

variable "vnet_links" {
  description = "Map of VNet links to create for each DNS zone"
  type = map(object({
    vnet_id              = string
    registration_enabled = bool
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}