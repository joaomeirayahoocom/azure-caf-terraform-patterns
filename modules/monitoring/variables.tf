variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "log_analytics_name" {
  description = "Log Analytics workspace name"
  type        = string
}

variable "sku" {
  description = "Log Analytics SKU"
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "Data retention in days"
  type        = number
  default     = 30
  validation {
    condition     = var.retention_in_days >= 30 && var.retention_in_days <= 730
    error_message = "Retention must be between 30 and 730 days."
  }
}

variable "daily_quota_gb" {
  description = "Daily ingestion quota in GB (-1 for unlimited)"
  type        = number
  default     = -1
}

variable "enable_application_insights" {
  description = "Create Application Insights resource"
  type        = bool
  default     = false
}

variable "application_insights_name" {
  description = "Application Insights name"
  type        = string
  default     = ""
}

variable "application_type" {
  description = "Application Insights type"
  type        = string
  default     = "web"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}