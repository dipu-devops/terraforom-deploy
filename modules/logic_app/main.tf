resource "azurerm_logic_app_workflow" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  # CORRECTED workflow_parameters format
  workflow_parameters = {
    "Environment" = jsonencode({
      type         = "String"
      defaultValue = var.environment
    })
  }

  tags = merge(var.tags, {
    Environment = var.environment
    Solution    = "AIS File Transfer"
  })
}