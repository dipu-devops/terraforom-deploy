resource "random_id" "resource_suffix" {
  byte_length = 4
}

resource "azurerm_key_vault" "main" {
  name = substr("${replace(lower(var.name), "/[^a-z0-9]/", "")}${var.suffix}", 0, 24)
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  enabled_for_disk_encryption = true
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.admin_object_id

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"
    ]
  }

  tags = {
    Environment = var.environment
  }
}
