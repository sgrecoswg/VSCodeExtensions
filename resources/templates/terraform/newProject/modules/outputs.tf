output "region" {
    description = ""
    sensitive  = false #true if you want to hide this from the outputs in the apply
    value = var.region
}