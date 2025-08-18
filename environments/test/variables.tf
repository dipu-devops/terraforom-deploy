variable "location" {
  description = "Azure region"
  type        = string
  default     = "uksouth"
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

variable "admin_object_id" {
  description = "Admin object ID for Key Vault access"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, tst, prd)"
  type        = string
}

variable "suffix" {
  description = "Unique suffix for resources"
  type        = string
}

variable "allowed_ips" {
  description = "Allowed IPs for storage accounts"
  type        = list(string)
  default     = []
}

variable "bypass_services" {
  description = "Services allowed to bypass network rules"
  type        = list(string)
  default     = ["AzureServices"]
}