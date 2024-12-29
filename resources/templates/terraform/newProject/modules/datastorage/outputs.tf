output "name" {
    description = ""
    sensitive  = false #true if you want to hide this from the outputs in the apply
    value = "value"
}

output "location" {
    description = ""
    sensitive  = false #true if you want to hide this from the outputs in the apply
    value = "value"
}

output "accountid" {
    description = ""
    sensitive  = false #true if you want to hide this from the outputs in the apply
    value = azurerm_storage_account.st.id
}

