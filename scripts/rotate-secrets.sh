#!/bin/bash
# Rotate storage account access keys
ENV=${1:-dev}
ACCOUNT=${2:-core}

echo "Rotating keys for $ACCOUNT in $ENV"

# Get current keys
PRIMARY_KEY=$(az storage account keys list \
  --resource-group rg-storage-$ENV \
  --account-name stais${ACCOUNT}${ENV}001 \
  --query '[0].value' -o tsv)

# Regenerate secondary key
az storage account keys renew \
  --resource-group rg-storage-$ENV \
  --account-name stais${ACCOUNT}${ENV}001 \
  --key secondary

# Update Key Vault
az keyvault secret set \
  --vault-name kv-ais-core-$ENV-001 \
  --name "Storage-${ACCOUNT}-Key" \
  --value $PRIMARY_KEY

echo "Key rotation complete. Applications will automatically use new key on next restart."