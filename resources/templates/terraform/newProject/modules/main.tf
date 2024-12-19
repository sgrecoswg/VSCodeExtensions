
module "resourcegroups" {
 source = "./modules/resourcegroups"
 should-deploy = var.should-deploy
 app-env = local.app_metadata.app_env
 app-name      = var.app-name
 region        = var.region.location
}

module "datastorage" {
 source = "./modules/datastorage"
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
  depends_on    =[module.datastorage]
  should-deploy = var.should-deploy
  app-env       = var.app-env
  app-name      = var.app-name
  region        = var.region.location
  rg-name   = module.resourcegroups.name
  sa-name  = module.datastorage.name
  storageaccountid = module.datastorage.accountid
}

module "managedidentity" {
  source        = "./managedidentity"
  depends_on    = [module.storageaccount]
  should-deploy = var.should-deploy
  app-env       = var.app-env
  app-name      = var.app-name
  rg-location   = module.resourcegroups.location
  rg-name       = module.resourcegroups.name
}

module "rediscache" {
 source = "./modules/rediscache"
 should-deploy = var.should-deploy
 app-env = local.app_metadata.app_env
}



module "loganalytics" {
 source = "./modules/loganalytics"
 should-deploy = var.should-deploy
 app-env = local.app_metadata.app_env
}

module "keyvault" {
 source = "./modules/keyvault"
 depends_on    =[module.resourcegroups]
 should-deploy = var.should-deploy
 app-env = local.app_metadata.app_env
}

module "gsloadbalancer" {
 source = "./modules/gsloadbalancer"
 should-deploy = var.should-deploy
 app-env = local.app_metadata.app_env
}

module "appservice" {
 source = "./modules/appservice"
 should-deploy = var.should-deploy
 app-env = local.app_metadata.app_env
}

module "appinsights" {
 source = "./modules/appinsights"
 should-deploy = var.should-deploy
 app-env = local.app_metadata.app_env
}

module "appgateway" {
 source = "./modules/appgateway"
 should-deploy = var.should-deploy
 app-env = local.app_metadata.app_env
}