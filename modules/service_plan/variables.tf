variable "name" {
  description = "Base name for service plan"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "prefix" {
  description = "Naming prefix"
  type        = string
  default     = "ais"
}

variable "suffix" {
  description = "Naming suffix"
  type        = string
  default     = "001"
}

variable "os_type" {
  description = "OS type (Windows or Linux)"
  type        = string
  default     = "Linux"
}

variable "sku_name" {
  description = "SKU name"
  type        = string
  default     = "B1"
}

variable "worker_count" {
  description = "Number of workers"
  type        = number
  default     = 1
}

variable "per_site_scaling" {
  description = "Enable per-site scaling"
  type        = bool
  default     = false
}

variable "zone_balancing_enabled" {
  description = "Enable zone balancing"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}