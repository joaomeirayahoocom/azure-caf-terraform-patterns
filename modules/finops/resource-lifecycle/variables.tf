variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "automation_account_name" {
  description = "Automation account name"
  type        = string
}

variable "enable_vm_auto_shutdown" {
  description = "Enable auto-shutdown runbook for non-prod VMs"
  type        = bool
  default     = true
}

variable "shutdown_time" {
  description = "Daily shutdown time (HH:MM format, 24hr)"
  type        = string
  default     = "19:00"
}

variable "shutdown_timezone" {
  description = "Timezone for shutdown schedule"
  type        = string
  default     = "Eastern Standard Time"
}

variable "environment_tag_name" {
  description = "Tag name used to identify environment"
  type        = string
  default     = "Environment"
}

variable "non_prod_environments" {
  description = "Environment tag values considered non-prod"
  type        = list(string)
  default     = ["dev", "test", "sandbox"]
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}