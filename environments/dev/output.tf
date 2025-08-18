# output "storage_accounts" {
#   value = {
#     main    = module.storage_statsfiledev.name
#     sftp    = module.storage_statsfileshpdev.name
#     malware = module.storage_statsfilemdsdev.name
#     archive = module.storage_statsfilearchdev.names
#   }
# }
output "storage_accounts_ids" {
  value = {
    main    = module.storage_statsfiledev.id
    sftp    = module.storage_statsfileshpdev.id
    malware = module.storage_statsfilemdsdev.id
    archive = module.storage_statsfilearchdev.id
  }
}

output "key_vault_name" {
  value = module.key_vault.name
}

output "data_factories" {
  value = {
    ingest = module.adf_ingest.name
    orch   = module.adf_orch.name
  }
}

output "function_app_name" {
  value = module.function_app.name
}

output "event_grid_name" {
  value = module.event_grid.name
}