output "rg-output" {
    description = ""
    sensitive  = false #true if you want to hide this from the outputs in the apply
    value = "value"
}

output "name" {
    description = ""
    sensitive  = false #true if you want to hide this from the outputs in the apply
    value = azurerm_resource_group.rg[0].name
}

output "location" {
    description = ""
    sensitive  = false #true if you want to hide this from the outputs in the apply
    value = azurerm_resource_group.rg[0].location
}