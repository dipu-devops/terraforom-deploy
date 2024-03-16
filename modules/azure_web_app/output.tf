output "service_plan_id" {
  value = azurerm_service_plan.azureappjia.id
}

output "web_app_id" {
  value = azurerm_windows_web_app.azureappjia.id
}
