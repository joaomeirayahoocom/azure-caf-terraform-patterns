variable "org_prefix" {
  description = "Organization prefix for resource naming (2-4 characters)"
  type        = string
  validation {
    condition     = length(var.org_prefix) >= 2 && length(var.org_prefix) <= 4
    error_message = "Organization prefix must be 2-4 characters."
  }
}

variable "environment" {
  description = "Environment name"
  type        = string
  validation {
    condition     = contains(["dev", "test", "staging", "prod", "sandbox"], var.environment)
    error_message = "Environment must be: dev, test, staging, prod, or sandbox."
  }
}

variable "default_location" {
  description = "Default Azure region for resources"
  type        = string
  default     = "eastus2"
}

variable "default_tags" {
  description = "Default tags applied to all resources"
  type        = map(string)
  default     = {}
}