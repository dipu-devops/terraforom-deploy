variable "resource_group_name" {
  description = "The name of the Azure resource group"
}

variable "location" {
  description = "The location for all Azure resources"
}

variable "service_plan_name" {
  description = "The name of the Azure App Service Plan"
}

variable "sku_name" {
  description = "The SKU name for the App Service Plan"
}

variable "os_type" {
  description = "The operating system type for the App Service Plan"
}

variable "web_app_name" {
  description = "The name of the Azure Web App"
}
