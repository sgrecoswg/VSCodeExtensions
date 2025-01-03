module "resourcegroups" {
  source        = "./resourcegroups"
  should-deploy = var.should-deploy
  app-env       = var.app-env
  app-name      = var.app-name
  region        = var.region.location
}

module "storageaccount" {
  source        = "./datastorage"
  depends_on    = [module.resourcegroups]
  rg-name       = module.resourcegroups.name
  rg-location   = module.resourcegroups.location
  should-deploy = var.should-deploy
  app-env       = var.app-env
  app-name      = var.app-name
  region        = var.region.location
}

module "blobstorage" {
  source        = "./blobstorage"
  depends_on    =[module.storageaccount]
  should-deploy = var.should-deploy
  app-env       = var.app-env
  app-name      = var.app-name
  region        = var.region.location
  rg-name       = module.resourcegroups.name
  sa-name       = module.storageaccount.name
  storageaccountid = module.storageaccount.accountid
}

module "managedidentity" {
  source        = "./managedidentity"
  depends_on    = [module.resourcegroups]
  should-deploy = var.should-deploy
  app-env       = var.app-env
  app-name      = var.app-name
  rg-location   = module.resourcegroups.location
  rg-name       = module.resourcegroups.name
}

module "rediscache" {
  source        = "./rediscache"
  depends_on    = [module.resourcegroups]
  should-deploy = var.should-deploy
  app-env       = var.app-env
  app-name      = var.app-name
  rg-location   = module.resourcegroups.location
  rg-name       = module.resourcegroups.name
}

module "keyvault" {
  source        = "./keyvault"
  depends_on    = [module.resourcegroups,module.managedidentity]
  should-deploy = var.should-deploy
  app-env       = var.app-env
  app-name      = var.app-name
  rg-location   = module.resourcegroups.location
  rg-name       = module.resourcegroups.name
  tenant-id     = data.azurerm_client_config.current.tenant_id
  object-id     = data.azurerm_client_config.current.object_id
  key_ops = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  sku_name = "standard"
}

module "appinsights" {
  source        = "./appinsights"
  depends_on    = [module.resourcegroups]
  should-deploy = var.should-deploy
  app-env       = var.app-env
  app-name      = var.app-name
  rg-location   = module.resourcegroups.location
  rg-name       = module.resourcegroups.name  
}

module "appgateway" {
  source        = "./appgateway"
  depends_on    = [module.resourcegroups]
  should-deploy = var.should-deploy
  app-env       = var.app-env
  app-name      = var.app-name
  rg-location   = module.resourcegroups.location
  rg-name       = module.resourcegroups.name  
  region        = module.resourcegroups.location
  virtual-network-ip-set = var.virtual-network-ip-set
  virtual-subnet-ip-set = var.virtual-subnet-ip-set
  virtual-failover-subnet-ip-set = var.virtual-failover-subnet-ip-set
  gw-path = var.gw-path 
}


module "appservice" {
  source        = "./appservice"
  depends_on    = [module.resourcegroups]
  should-deploy = var.should-deploy
  app-env       = var.app-env
  app-name      = var.app-name
  rg-location   = module.resourcegroups.location
  rg-name       = module.resourcegroups.name  
  region        = module.resourcegroups.location     
  dotnet-framework = var.dotnet-framework
  source-control = var.source-control
  connection-string = {
    name  = var.connection-string.name
    type  = var.connection-string.type
    value = var.connection-string.value
  }  
  app-settings = {
    "SOME_KEY" = "some-value"
  }
  sku= var.sku
  os = var.os
}


