
resource "azurerm_service_plan" "sp" {
  name                = "service-plan-${var.app-name}-${var.app-env}-${var.region}"
  resource_group_name = var.rg-name
  location            = var.rg-location
  sku_name            = var.sku
  os_type             = var.os
  tags = {
    environment = var.app-env
  } 
}

resource "azurerm_app_service" "appservice" {
  name                = "app-service-${var.app-name}-${var.app-env}-${var.region}"  
  resource_group_name = var.rg-name
  location            = var.rg-location
  app_service_plan_id = azurerm_service_plan.sp.id
  app_settings        = var.app-settings

  connection_string {
    name  = var.connection-string.name
    type  = var.connection-string.type
    value = var.connection-string.value
  }  

  site_config {
    dotnet_framework_version  = var.dotnet-framework
    scm_type                  = var.source-control
    always_on                 = false // Required for F1 plan
    use_32_bit_worker_process = true  // Required for F1 plan
  }  

  tags = {
    environment = var.app-env
  }
}