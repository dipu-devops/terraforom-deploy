resource "azurerm_monitor_diagnostic_setting" "main" {
  name                       = "diag-${var.resource_type}-${var.resource_name}"
  target_resource_id         = var.resource_id
  log_analytics_workspace_id = var.workspace_id

  dynamic "enabled_log" {
    for_each = var.log_categories
    content {
      category = enabled_log.value
    }
  }

  enabled_metric {
    category = "AllMetrics"
  }
}