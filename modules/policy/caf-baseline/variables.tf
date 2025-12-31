variable "management_group_id" {
  description = "Management group ID to assign policies to"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID for diagnostic settings"
  type        = string
  default     = ""
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