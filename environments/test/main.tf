# Unique resource suffix
resource "random_id" "resource_suffix" {
  byte_length = 4
}

# Core Resource Groups (with prevent_destroy to avoid conflicts)
resource "azurerm_resource_group" "storage" {
  name     = "rg-aisfile-storage-${var.environment}"
  location = var.location
  #lifecycle { prevent_destroy = true }
}

resource "azurerm_resource_group" "log" {
  name     = "rg-aisfile-log-${var.environment}"
  location = var.location
  #lifecycle { prevent_destroy = true }
}

resource "azurerm_resource_group" "kv" {
  name     = "rg-aisfile-kv-${var.environment}"
  location = var.location
  #lifecycle { prevent_destroy = true }
}

resource "azurerm_resource_group" "eg" {
  name     = "rg-aisfile-e9-${var.environment}"
  location = var.location
  #lifecycle { prevent_destroy = true }
}

resource "azurerm_resource_group" "adf" {
  name     = "rg-aisfile-adf-${var.environment}"
  location = var.location
  #lifecycle { prevent_destroy = true }
}

resource "azurerm_resource_group" "logic" {
  name     = "rg-aisfile-logic-${var.environment}"
  location = var.location
  #lifecycle { prevent_destroy = true }
}

resource "azurerm_resource_group" "func" {
  name     = "rg-aisfile-func-${var.environment}"
  location = var.location
 # lifecycle { prevent_destroy = true }
}

# Storage Accounts with explicit allowed_ips
module "storage_statsfiledev" {
  source = "../../modules/storage_account"

  name                = "st${substr(random_id.resource_suffix.hex, 0, 8)}"
  resource_group_name = azurerm_resource_group.storage.name
  location            = var.location
  environment         = var.environment
  account_tier        = "Standard"
  replication_type    = "LRS"
  containers          = ["ingress", "processed"]
  allowed_ips         = []  # Explicitly set empty list
  bypass_services     = ["AzureServices"]
  
  depends_on = [time_sleep.resource_group_propagation]
}

module "storage_statsfileshpdev" {
  source = "../../modules/storage_account"

  name                = "sftp${substr(random_id.resource_suffix.hex, 0, 8)}"
  resource_group_name = azurerm_resource_group.storage.name
  location            = var.location
  environment         = var.environment
  account_tier        = "Standard"
  replication_type    = "LRS"
  allowed_ips         = []  # Explicitly set empty list
  bypass_services     = ["AzureServices"]
  
  depends_on = [time_sleep.resource_group_propagation]
}

module "storage_statsfilemdsdev" {
  source = "../../modules/storage_account"

  name                = "mds${substr(random_id.resource_suffix.hex, 0, 8)}"
  resource_group_name = azurerm_resource_group.storage.name
  location            = var.location
  environment         = var.environment
  account_tier        = "Standard"
  replication_type    = "LRS"
  enable_versioning   = true
  allowed_ips         = []  # Explicitly set empty list
  bypass_services     = ["AzureServices"]
  
  depends_on = [time_sleep.resource_group_propagation]
}

module "storage_statsfilearchdev" {
  source = "../../modules/storage_account"

  name                = "arch${substr(random_id.resource_suffix.hex, 0, 8)}"
  resource_group_name = azurerm_resource_group.storage.name
  location            = var.location
  environment         = var.environment
  account_tier        = "Standard"
  replication_type    = "GRS"
  allowed_ips         = []  # Explicitly set empty list
  bypass_services     = ["AzureServices"]
  
  depends_on = [time_sleep.resource_group_propagation]
}


# Delay to ensure resource groups are fully propagated
resource "time_sleep" "resource_group_propagation" {
  depends_on = [
    azurerm_resource_group.storage,
    azurerm_resource_group.log,
    azurerm_resource_group.kv,
    azurerm_resource_group.eg,
    azurerm_resource_group.adf,
    azurerm_resource_group.logic,
    azurerm_resource_group.func
  ]
  
  create_duration = "30s"
}

# Log Analytics
module "log_analytics" {
  source = "../../modules/log_analytics"

  name                = "log-${var.environment}-${substr(random_id.resource_suffix.hex, 0, 4)}"
  resource_group_name = azurerm_resource_group.log.name
  location            = var.location
  environment         = var.environment
  
  depends_on = [time_sleep.resource_group_propagation]
}

# Key Vault
module "key_vault" {
  source = "../../modules/key_vault"

  name                = "kv-${var.environment}-${substr(random_id.resource_suffix.hex, 0, 8)}"
  resource_group_name = azurerm_resource_group.kv.name
  location            = var.location
  environment         = var.environment
  tenant_id           = var.tenant_id
  admin_object_id     = var.admin_object_id
  suffix              = random_id.resource_suffix.hex
  depends_on = [time_sleep.resource_group_propagation]
}

# Event Grid
module "event_grid" {
  source = "../../modules/event_grid"

  name                = "eg-${var.environment}-${substr(random_id.resource_suffix.hex, 0, 4)}"
  resource_group_name = azurerm_resource_group.eg.name
  location            = var.location
  environment         = var.environment
  
  depends_on = [time_sleep.resource_group_propagation]
}

# Data Factories (with unique names)
module "adf_ingest" {
  source = "../../modules/data_factory"

  name                = "adf-ingest-${var.environment}-${substr(random_id.resource_suffix.hex, 0, 4)}"
  resource_group_name = azurerm_resource_group.adf.name
  location            = var.location
  environment         = var.environment
  component           = "ingest"
  
  depends_on = [time_sleep.resource_group_propagation]
}

module "adf_orch" {
  source = "../../modules/data_factory"

  name                = "adf-orch-${var.environment}-${substr(random_id.resource_suffix.hex, 0, 4)}"
  resource_group_name = azurerm_resource_group.adf.name
  location            = var.location
  environment         = var.environment
  component           = "orchestration"
  
  depends_on = [time_sleep.resource_group_propagation]
}

# Application Insights
module "app_insights" {
  source = "../../modules/application_insights"

  name                       = "appi-${var.environment}-${substr(random_id.resource_suffix.hex, 0, 4)}"
  resource_group_name        = azurerm_resource_group.func.name
  location                   = var.location
  environment                = var.environment
  log_analytics_workspace_id = module.log_analytics.id
  
  depends_on = [
    time_sleep.resource_group_propagation,
    module.log_analytics
  ]
}

# Function App with managed identity
# module "function_app" {
#   source = "../../modules/function_app"

#   name                       = "func-${var.environment}-${substr(random_id.resource_suffix.hex, 0, 4)}"
#   resource_group_name        = azurerm_resource_group.func.name
#   location                   = var.location
#   environment                = var.environment
#   storage_account_name       = module.storage_statsfiledev.name
#   storage_account_access_key = module.storage_statsfiledev.primary_access_key
#   app_insights_key           = module.app_insights.instrumentation_key
#   storage_account_id         = module.storage_statsfiledev.id
  
#   depends_on = [
#     time_sleep.resource_group_propagation,
#     module.storage_statsfiledev,
#     module.app_insights
#   ]
# }

module "function_app" {
  source = "../../modules/function_app"

  name                 = "func-${var.environment}-${substr(random_id.resource_suffix.hex, 0, 4)}"
  resource_group_name  = azurerm_resource_group.func.name
  location             = var.location
  environment          = var.environment
  storage_account_name = module.storage_statsfiledev.name
  app_insights_key     = module.app_insights.instrumentation_key
  storage_account_id   = module.storage_statsfiledev.id
  #storage_key_vault_secret_id = "<your-key-vault-secret-id>"
  depends_on = [
    time_sleep.resource_group_propagation,
    module.storage_statsfiledev,
    module.app_insights,
    #azurerm_role_assignment.func_storage_access
  ]
}

# # Role assignment for managed identity
# resource "azurerm_role_assignment" "func_storage_access" {
#   scope                = module.storage_statsfiledev.id
#   role_definition_name = "Storage Blob Data Contributor"
#   principal_id         = module.function_app.identity_principal_id
# }

# 
resource "azurerm_role_assignment" "func_storage_access" {
  scope                = module.storage_statsfiledev.id  # or the storage account resource id you use
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.function_app.identity_principal_id  # output this from your module

  depends_on = [
    module.function_app
  ]
}




# Logic App
module "logic_app" {
  source = "../../modules/logic_app"

  name                = "la-${var.environment}-${substr(random_id.resource_suffix.hex, 0, 4)}"
  resource_group_name = azurerm_resource_group.logic.name
  location            = var.location
  environment         = var.environment
  
  depends_on = [time_sleep.resource_group_propagation]
}
