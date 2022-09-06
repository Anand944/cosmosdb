# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg02"
  location = "East Us"
}
resource "azurerm_cosmosdb_account" "dbaccount" {
  name                = "siddudbaccount"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = true

  consistency_policy {
    consistency_level       = "Session"

  }

  geo_location {
    location          = "westus"
    failover_priority = 1
  }

  geo_location {
    location          = "eastus"
    failover_priority = 0
  }
}
resource "azurerm_cosmosdb_sql_database" "db" {
  name                = "products"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.dbaccount.name

}
resource "azurerm_cosmosdb_sql_container" "coll" {
  name                  = "Devices"
  resource_group_name   = azurerm_resource_group.rg.name
  account_name          = azurerm_cosmosdb_account.dbaccount.name
  database_name         = azurerm_cosmosdb_sql_database.db.name
  partition_key_path    = "/Devices"

}