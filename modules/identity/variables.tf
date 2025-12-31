variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "identity_name" {
  description = "User-assigned managed identity name"
  type        = string
}

variable "role_assignments" {
  description = "Role assignments for the managed identity"
  type = map(object({
    scope                = string
    role_definition_name = string
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}