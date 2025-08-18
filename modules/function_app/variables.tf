variable "name" {
  description = "Function App name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "uksouth"
}

variable "environment" {
  description = "Environment (dev, tst, prd)"
  type        = string
  default     = "dev"
}

variable "business_unit" {
  description = "Business unit (core, biz, etc.)"
  type        = string
  default     = "core"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

variable "app_insights_key" {
  description = "Application Insights key"
  type        = string
  sensitive   = true
  default     = null  # Make it optional
}

variable "storage_account_id" {
  description = "Storage Account ID for explicit dependency"
  type        = string
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name for function app"
  validation {
    condition     = length(var.storage_account_name) > 0
    error_message = "storage_account_name cannot be empty"
  }
}

