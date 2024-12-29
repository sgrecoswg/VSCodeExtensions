# output "app_metadata" {
#   description = ""
#   sensitive   = false #true if you want to hide this from the outputs in the apply
#   value       = local.app_metadata
# }

# output "regions" {
#   description = ""
#   sensitive   = false #true if you want to hide this from the outputs in the apply
#   value       = local.active_regions
# }

# output "deployedregions" {
#   description = ""
#   sensitive   = true #true if you want to hide this from the outputs in the apply
#   value       = module.mainentry
# }

# output "mi" {
#   description = ""
#   sensitive   = false #true if you want to hide this from the outputs in the apply
#   value       = module.mainentry["centralus"].mi
# }

# output "keyvault" {
#   description = ""
#   sensitive   = false #true if you want to hide this from the outputs in the apply
#   value       = module.mainentry["centralus"].kv
# }

# output "currentuser" {
#   description = ""
#   sensitive   = false #true if you want to hide this from the outputs in the apply
#   value       = module.mainentry["centralus"].currentuser
# }

# output "gateway" {
#   description = ""
#   sensitive   = false #true if you want to hide this from the outputs in the apply
#   value       = module.mainentry["centralus"].gateway
# }

