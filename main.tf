provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "dev_env"
    storage_account_name = "devenvstorageji"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}


module "azure_web_app" {
  source                         = "./modules/azure_web_app"
  existing_resource_group_name   = var.resource_group_name
  service_plan_name              = var.service_plan_name
  sku_name                       = var.sku_name
  os_type                        = var.os_type
  web_app_name                   = var.web_app_name
}

# You can include more Terraform code here or reference other modules
