output "app_metadata" {
  description = ""
  sensitive   = false #true if you want to hide this from the outputs in the apply
  value       = local.app_metadata
}

output "regions" {
  description = ""
  sensitive   = false #true if you want to hide this from the outputs in the apply
  value       = local.regions
}

output "deployedregions" {
  description = ""
  sensitive   = false #true if you want to hide this from the outputs in the apply
  value       = module.mainentry
}
