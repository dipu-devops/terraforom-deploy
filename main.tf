provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "azureapp-resources"
    storage_account_name = "terraformdeployji"
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

resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "Allow_All_Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}
# You can include more Terraform code here or reference other moduless
