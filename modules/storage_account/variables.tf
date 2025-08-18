variable "name" {
  description = "Storage account name"
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

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "Replication type"
  type        = string
  default     = "LRS"
}

variable "containers" {
  description = "List of container names"
  type        = list(string)
  default     = ["data"]
}

variable "public_access" {
  description = "Allow public access"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Enable blob versioning"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

# Add new variable
variable "bypass_services" {
  description = "Services allowed to bypass network rules"
  type        = list(string)
  default     = ["AzureServices"]  # Default allow Azure services
}

variable "allowed_ips" {
  description = "List of allowed IP addresses"
  type        = list(string)
  default     = []
}