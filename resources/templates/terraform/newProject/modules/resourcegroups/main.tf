resource "azurerm_resource_group" "sample-rg" {
  count = var.should-deploy ? 1 : 0
  name     = "sample-resource-${var.app-env}"
  location = "East Us"
  tags = {
    environment = "${var.app-env}"
  }
}