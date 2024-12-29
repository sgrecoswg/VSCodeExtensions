# output "gw" {
#     description = ""
#     sensitive  = false #true if you want to hide this from the outputs in the apply
#     value = azurerm_application_gateway.gw
# }

output "virtual-network" {
    description = ""
    sensitive  = false #true if you want to hide this from the outputs in the apply
    value = azurerm_virtual_network.n
}

output "subnet" {
    description = ""
    sensitive  = false #true if you want to hide this from the outputs in the apply
    value = azurerm_subnet.subnet
}

output "failoversubnet" {
    description = ""
    sensitive  = false #true if you want to hide this from the outputs in the apply
    value = azurerm_subnet.failoversubnet
}
