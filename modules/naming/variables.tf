variable "org_prefix" {
  description = "Organization prefix (2-4 characters)"
  type        = string
  validation {
    condition     = length(var.org_prefix) >= 2 && length(var.org_prefix) <= 4
    error_message = "Organization prefix must be 2-4 characters."
  }
}

variable "workload" {
  description = "Workload or application name"
  type        = string
  validation {
    condition     = length(var.workload) <= 15
    error_message = "Workload name must be 15 characters or less."
  }
}

variable "environment" {
  description = "Environment (dev, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be: dev or prod."
  }
}
variable "region" {
  description = "Azure region"
  type        = string
  default     = "eastus2"
}

variable "instance" {
  description = "Instance number for multiple resources"
  type        = string
  default     = "001"
}

variable "cost_center" {
  description = "Cost center for tagging"
  type        = string
  default     = ""
}

variable "owner" {
  description = "Owner for tagging"
  type        = string
  default     = ""
}

variable "data_classification" {
  description = "Data classification for tagging"
  type        = string
  default     = "Internal"
}