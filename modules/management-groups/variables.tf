variable "root_id" {
  description = "Root management group ID (your org name)"
  type        = string
}

variable "root_display_name" {
  description = "Root management group display name"
  type        = string
}

variable "create_platform_mg" {
  description = "Create Platform management group and children"
  type        = bool
  default     = true
}

variable "create_landing_zones_mg" {
  description = "Create Landing Zones management group and children"
  type        = bool
  default     = true
}

variable "create_decommissioned_mg" {
  description = "Create Decommissioned management group"
  type        = bool
  default     = true
}