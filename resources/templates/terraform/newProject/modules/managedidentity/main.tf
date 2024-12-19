resource "azurerm_user_assigned_identity" "example" {    
   count               = var.should-deploy ? 1 : 0
   location            = var.rg-location 
   name                = lower(format("%s%s%s","mi-",var.app-name,var.rg-location))
   resource_group_name = var.rg-name
}