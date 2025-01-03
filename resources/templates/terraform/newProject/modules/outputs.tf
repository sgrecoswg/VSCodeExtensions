output "region" {
    description = ""
    sensitive  = false #true if you want to hide this from the outputs in the apply
    value = var.region
}

# output "mi" {
#   description = ""
#   sensitive   = false #true if you want to hide this from the outputs in the apply
#   value       = module.managedidentity.mi-ouput
# }

# output "kv" {
#   description = ""
#   sensitive   = false #true if you want to hide this from the outputs in the apply
#   value       = module.keyvault.azurerm_key_vault_name
# }

# output "appinsights" {
#   description = ""
#   sensitive   = false #true if you want to hide this from the outputs in the apply
#   value       = module.appinsights
# }

output "currentuser" {
  description = ""
  sensitive   = false #true if you want to hide this from the outputs in the apply
  value       = data.azurerm_client_config.current
}

output "gateway" {
  description = ""
  sensitive   = false #true if you want to hide this from the outputs in the apply
  value       = module.appgateway
}

# output "appservices" {
#   description = ""
#   sensitive   = true #true if you want to hide this from the outputs in the apply
#   value       = module.appservice
# }