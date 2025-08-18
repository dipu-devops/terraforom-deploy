variable "name" {
  description = "Application Insights name"
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

variable "application_type" {
  description = "Application type (web, other)"
  type        = string
  default     = "web"
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  type        = string
  default     = null
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}