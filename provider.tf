provider "azurerm"{
    version = "~>2.0"
    features {}
}

terraform {
  backend "azurerm" {
    resource_group_name = "rg-dev07"
    storage_account_name = "ccpsazuref003"
    container_name = "ccpterraformstatefile"
    key            = "ccpsterraform.tfstate"
  }
}