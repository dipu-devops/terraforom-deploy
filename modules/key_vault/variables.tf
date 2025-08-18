variable "name" {
  description = "Key Vault name"
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

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

variable "admin_object_id" {
  description = "Admin object ID"
  type        = string
}

variable "environment" {
  description = "Environment (dev, tst, prd)"
  type        = string
  default     = "dev"
}

variable "purge_protection" {
  description = "Enable purge protection"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

variable "suffix" {
  description = "Unique suffix for resource names"
  type        = string
}