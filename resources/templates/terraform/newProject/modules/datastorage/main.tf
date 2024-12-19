resource "azurerm_storage_account" "st" {
  name                     = "sa${var.app-env}${var.region}"
  resource_group_name      = var.rg-name
  location                 = var.rg-location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}