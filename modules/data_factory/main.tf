resource "azurerm_data_factory" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  
  identity {
    type = "SystemAssigned"
  }

  global_parameter {
    name  = "Environment"
    type  = "String"
    value = var.environment
  }

  tags = merge(var.tags, {
    Environment = var.environment
    Solution    = "AIS File Transfer"
    Component   = var.component
  })
}