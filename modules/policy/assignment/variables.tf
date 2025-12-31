variable "name" {
  description = "Policy assignment name"
  type        = string
}

variable "display_name" {
  description = "Policy assignment display name"
  type        = string
}

variable "description" {
  description = "Policy assignment description"
  type        = string
  default     = ""
}

variable "policy_definition_id" {
  description = "Policy or initiative definition ID"
  type        = string
}

variable "scope" {
  description = "Scope for policy assignment (management group, subscription, or resource group ID)"
  type        = string
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

variable "parameters" {
  description = "Policy parameters as JSON string"
  type        = string
  default     = "{}"
}

variable "non_compliance_message" {
  description = "Message shown for non-compliant resources"
  type        = string
  default     = "Resource is not compliant with organizational policies."
}