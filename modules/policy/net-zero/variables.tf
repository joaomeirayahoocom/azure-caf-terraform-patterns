variable "management_group_id" {
  description = "Management group ID to assign policies to"
  type        = string
}

variable "allowed_regions" {
  description = "List of allowed Azure regions (prefer low-carbon regions)"
  type        = list(string)
  default     = ["eastus2", "westus2", "northeurope", "swedencentral"]
}

variable "enforcement_mode" {
  description = "Policy enforcement mode (Default or DoNotEnforce)"
  type        = string
  default     = "Default"
  validation {
    condition     = contains(["Default", "DoNotEnforce"], var.enforcement_mode)
    error_message = "Enforcement mode must be Default or DoNotEnforce."
  }
}

variable "require_auto_shutdown" {
  description = "Require auto-shutdown on non-prod VMs"
  type        = bool
  default     = true
}