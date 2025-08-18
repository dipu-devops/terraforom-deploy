resource "azurerm_service_plan" "main" {
  name                = "asp-${var.prefix}-${var.environment}-${var.suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type
  sku_name            = var.sku_name
  worker_count        = var.worker_count
#   per_site_scaling    = var.per_site_scaling
  zone_balancing_enabled = var.zone_balancing_enabled

  tags = merge(var.tags, {
    environment = var.environment
    component   = "compute"
  })
}