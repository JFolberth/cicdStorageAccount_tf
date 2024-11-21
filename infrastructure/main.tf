provider "azurerm" {
  features {}
}
variable "base_name" {
  default     = "gitterraform"
  description = "Base name that will appear for all resources."
}
variable "environment_name" {
  description = "Three letter environment abreviation to denote environment that will appear in all resource names"
}
variable "resource_group_location" {
  description = "The azure location the resource group will be deployed to"
}
variable "storage_account_tier" {
  description = "Storage Account will be Standard or Premium"
}
variable "storage_account_replication_type" {
  description = "What type of replication will be required for the Storage Account"
}
variable "region_reference" {
  default = {
    centralus = "cus"
    eastus    = "eus"
    westus    = "wus"
    westus2   = "wus2"
  }
  description = "Object/map that will look up a full qualified region and convert it to an abreviation. Done to drive consistency"
}

locals {
  name_suffix = "${var.base_name}-${var.environment_name}-${lookup(var.region_reference, var.resource_group_location, "")}"
}

module "resource_group_module" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"
  location = var.resource_group_location
  name     = "rg-${local.name_suffix}"
}

module "avm-res-storage-storageaccount_module" {
  source                   = "Azure/avm-res-storage-storageaccount/azurerm"
  name                     = "sa${replace(local.name_suffix,"-","")}"
  location                 = var.resource_group_location
  account_replication_type = var.storage_account_replication_type
  account_tier             = var.storage_account_tier
  resource_group_name      = module.resource_group_module.name
}