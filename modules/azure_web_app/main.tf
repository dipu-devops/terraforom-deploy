data "azurerm_resource_group" "existing" {
  name = var.existing_resource_group_name
}

resource "azurerm_service_plan" "azureappjia" {
  name                = var.service_plan_name
  resource_group_name = data.azurerm_resource_group.existing.name
  location            = data.azurerm_resource_group.existing.location
  sku_name            = var.sku_name
  os_type             = var.os_type
}

resource "azurerm_windows_web_app" "azureappjia" {
  name                = var.web_app_name
  resource_group_name = data.azurerm_resource_group.existing.name
  location            = data.azurerm_resource_group.existing.location
  service_plan_id     = azurerm_service_plan.azureappjia.id

  site_config {}
}
