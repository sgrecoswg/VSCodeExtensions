output "appservices" {
    description = ""
    sensitive  = false #true if you want to hide this from the outputs in the apply
    value = {
        service = azurerm_app_service.appservice
        serviceplan = azurerm_service_plan.sp
    }
}