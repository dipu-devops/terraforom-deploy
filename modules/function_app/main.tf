
resource "azurerm_service_plan" "main" {
  name                = "asp-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.main.id
  storage_account_name          = var.storage_account_name
  storage_uses_managed_identity = true

  site_config {
    application_insights_key = var.app_insights_key
    always_on                = false
    
    application_stack {
      python_version = "3.11"
    }
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"           = "python"
    "AzureWebJobsStorage__accountName"  = var.storage_account_name
    "WEBSITE_CONTENTOVERVNET"            = "1"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.environment
  }
}
