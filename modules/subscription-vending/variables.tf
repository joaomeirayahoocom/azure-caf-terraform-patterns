variable "subscription_id" {
  description = "Existing subscription ID to configure"
  type        = string
}

variable "subscription_name" {
  description = "Display name for the subscription"
  type        = string
}

variable "management_group_id" {
  description = "Management group to place the subscription under"
  type        = string
}

variable "budget_amount" {
  description = "Monthly budget amount in USD"
  type        = number
  default     = 1000
}

variable "budget_alert_emails" {
  description = "Email addresses for budget alerts"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to subscription-level resources"
  type        = map(string)
  default     = {}
}