variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "app_service_plan_name" {
  description = "App Service Plan name"
  type        = string
}

variable "app_service_name" {
  description = "App Service (Web App) name"
  type        = string
}

variable "sku_name" {
  description = "App Service Plan SKU (B1, S1, P1v2, P1v3, etc.)"
  type        = string
  default     = "B1"
}

variable "os_type" {
  description = "OS type (Windows or Linux)"
  type        = string
  default     = "Linux"
  validation {
    condition     = contains(["Windows", "Linux"], var.os_type)
    error_message = "OS type must be Windows or Linux."
  }
}

variable "dotnet_version" {
  description = ".NET version (e.g., v6.0, v7.0, v8.0)"
  type        = string
  default     = null
}

variable "node_version" {
  description = "Node.js version (e.g., 18-lts, 20-lts)"
  type        = string
  default     = null
}

variable "python_version" {
  description = "Python version (e.g., 3.10, 3.11)"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID for VNet integration (optional)"
  type        = string
  default     = null
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for private endpoint (optional)"
  type        = string
  default     = null
}

variable "https_only" {
  description = "Redirect HTTP to HTTPS"
  type        = bool
  default     = true
}

variable "app_settings" {
  description = "Application settings"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}