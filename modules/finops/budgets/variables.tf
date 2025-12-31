variable "budget_name" {
  description = "Budget name"
  type        = string
}

variable "scope" {
  description = "Budget scope (subscription or resource group ID)"
  type        = string
}

variable "amount" {
  description = "Budget amount in USD"
  type        = number
}

variable "time_grain" {
  description = "Budget time grain (Monthly, Quarterly, Annually)"
  type        = string
  default     = "Monthly"
  validation {
    condition     = contains(["Monthly", "Quarterly", "Annually"], var.time_grain)
    error_message = "Time grain must be Monthly, Quarterly, or Annually."
  }
}

variable "alert_thresholds" {
  description = "Budget alert thresholds (percentage)"
  type        = list(number)
  default     = [50, 80, 100]
}

variable "alert_emails" {
  description = "Email addresses for budget alerts"
  type        = list(string)
}

variable "start_date" {
  description = "Budget start date (YYYY-MM-01 format)"
  type        = string
  default     = null
}