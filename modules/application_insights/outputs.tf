output "id" {
  value = azurerm_application_insights.main.id
}

output "name" {
  value = azurerm_application_insights.main.name
}

output "instrumentation_key" {
  value     = azurerm_application_insights.main.instrumentation_key
  sensitive = true
}

output "app_id" {
  value = azurerm_application_insights.main.app_id
}