//terraform configuration block
terraform {
  required_version = "~>1.12.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.25.0"
    }
  }

  cloud {

    organization = "tffand"

    workspaces {
      name = "terraform-modules"
    }
  }
}

locals {
  tags = {
    "Environment" = var.environment
  }
}

//no provider block -- it is in module
//no rg block -- it is in module too

//other resource block 
resource "azurerm_storage_account" "storageaccount" {
  name                          = var.storage_account_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  account_tier                  = "Standard"
  account_replication_type      = var.environment == "Production" ? "GRS" : "LRS"
  public_network_access_enabled = false

  tags = local.tags
}
