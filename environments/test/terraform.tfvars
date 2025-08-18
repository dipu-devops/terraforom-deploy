tenant_id = "58bb2541-3e96-4306-9a8c-ac5d1d090757"
# subscription_id = "2ba2da7b-7bc1-4d9e-93f5-3db94434f2bc"

environment = "dev"
location    = "uksouth"
suffix      = "001" # Change per environment
allowed_ips = []
bypass_services = ["AzureServices"]

# Get these values from Azure:
# tenant_id       = $(az account show --query tenantId -o tsv)
# admin_object_id = $(az ad signed-in-user show --query id -o tsv)

admin_object_id = "9c90dda4-0714-4c95-a7ff-a04beddb6145"