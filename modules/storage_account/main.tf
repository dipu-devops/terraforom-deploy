resource "azurerm_storage_account" "main" {
  name                     = substr(replace(lower(var.name), "/[^a-z0-9]/", ""), 0, 24)
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
  min_tls_version          = "TLS1_2"
  allow_nested_items_to_be_public = false

  network_rules {
    default_action = "Deny"
    bypass         = var.bypass_services
    ip_rules       = var.allowed_ips
  }

  tags = {
    Environment = var.environment
  }
}

# Container for function app content
resource "azurerm_storage_container" "function_content" {
  name                  = "function-content"
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = "private"
}

