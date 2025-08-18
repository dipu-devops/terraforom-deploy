output "id" {
  value = azurerm_linux_function_app.main.id
}

output "name" {
  value = azurerm_linux_function_app.main.name
}

# Output for identity
# output "identity_principal_id" {
#   value = azurerm_linux_function_app.main.identity[0].principal_id
# }
output "identity_principal_id" {
  value = azurerm_linux_function_app.main.identity[0].principal_id
  description = "The principal ID of the system-assigned managed identity"
}


