variable "resource_id" {
  description = "Resource ID to monitor"
  type        = string
}

variable "workspace_id" {
  description = "Log Analytics workspace ID"
  type        = string
}

variable "resource_type" {
  description = "Resource type (e.g., storage, adf)"
  type        = string
}

variable "resource_name" {
  description = "Resource name"
  type        = string
}

variable "log_categories" {
  description = "List of log categories to enable"
  type        = list(string)
  default     = []
}

variable "metric_categories" {
  description = "List of metric categories to enable"
  type        = list(string)
  default     = ["AllMetrics"]
}