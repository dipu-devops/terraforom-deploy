# terraform {
#   required_version = ">= 1.6.0"
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "4.40.0"
#     }
#   }
#   backend "azurerm" {
#     resource_group_name  = "ais-tfstate-rgji"
#     storage_account_name = "aistfstatedevji"
#     container_name       = "tfstate"
#     key                  = "ais-infra-dev.tfstate"
#   }
# }

terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.40.0"
    }
      time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "ais-tfstate-rgji"
    storage_account_name = "aistfstatedevji"
    container_name       = "tfstate"
    key                  = "ais-infra-dev.tfstate"
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
     resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "2ba2da7b-7bc1-4d9e-93f5-3db94434f2bc"
  tenant_id       = "58bb2541-3e96-4306-9a8c-ac5d1d090757"
}

provider "time" {}