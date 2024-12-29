resource "azurerm_storage_container" "sc" {
  name                  = "sc-${var.app-name}-${var.app-env}-${var.region}"
  storage_account_id    = var.storageaccountid
  container_access_type = "private"
}