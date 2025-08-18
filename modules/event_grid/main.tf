resource "azurerm_eventgrid_topic" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  input_schema        = "CloudEventSchemaV1_0"
  
  tags = merge(var.tags, {
    Environment = var.environment
    Solution    = "AIS File Transfer"
  })
}