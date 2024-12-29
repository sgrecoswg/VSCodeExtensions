resource "azurerm_resource_group" "rg" {
  count = var.should-deploy ? 1 : 0
  name     = "rg-${var.app-name}-${var.app-env}-${var.region}"
  location = var.region
  tags = {
    environment = "${var.app-env}"
  }
}