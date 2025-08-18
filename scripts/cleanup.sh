#!/bin/bash
# Clean up old Terraform state and cache
ENV=${1:-dev}

echo "Cleaning up environment: $ENV"

cd environments/$ENV

# Remove Terraform state files
rm -rf .terraform
rm -f terraform.tfstate*
rm -f tfplan

echo "Cleanup complete for $ENV"