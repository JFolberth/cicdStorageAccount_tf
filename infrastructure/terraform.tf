terraform {
  required_version = ">= 1.5.2"
  backend  "azurerm"{
    resource_group_name  = "my-tf-remote-state-rg-name"
    storage_account_name = "my-tf-remote-state-sa-name"
    container_name       = "my-tf-remote-state-container-name"
    key                  = "my-state-file-name.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.71"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 4.0.0"
    }
  }
}