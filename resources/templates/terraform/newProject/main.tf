terraform {
    backend "remote" {
        organization = "|organization|"
        hostname = "app.terraform.io"
        workspaces {
            prefix = "|workspaceprefix|"
        }
    },
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "4.14.0"
        }
        azuread = {
            source  = "hashicorp/azuread"
            version = "~> 2.0"
        }
        infoblox = {
            source  = "infobloxopen/infoblox"
            version = "~> 2.0"
        }
        azapi = {
            source  = "azure/azapi"
            version = "2.1.0"
        }
    }
    required_version = ">= 0.15.5"
}

provider "azurerm" {
    features {}
}

provider "infoblox" {
 
}

module "resourcegroups" {
 count = 1
 source = "./modules/resourcegroups"
 should-deploy = true
 app-env = local.app_metadata.app_env
}

module "rediscache" {
 count = 1
 source = "./modules/rediscache"
 should-deploy = true
 app-env = local.app_metadata.app_env
}

module "managedidentity" {
 count = 1
 source = "./modules/managedidentity"
 should-deploy = true
 app-env = local.app_metadata.app_env
}

module "loganalytics" {
 count = 1
 source = "./modules/loganalytics"
 should-deploy = true
 app-env = local.app_metadata.app_env
}

module "keyvault" {
 count = 1
 source = "./modules/keyvault"
 should-deploy = true
 app-env = local.app_metadata.app_env
}

module "gsloadbalancer" {
 count = 1
 source = "./modules/gsloadbalancer"
 should-deploy = true
 app-env = local.app_metadata.app_env
}

module "datastorage" {
 count = 1
 source = "./modules/datastorage"
 should-deploy = true
 app-env = local.app_metadata.app_env
}

module "blobstorage" {
 count = 1
 source = "./modules/blobstorage"
 should-deploy = true
 app-env = local.app_metadata.app_env
}

module "appservice" {
 count = 1
 source = "./modules/appservice"
 should-deploy = true
 app-env = local.app_metadata.app_env
}

module "appinsights" {
 count = 1
 source = "./modules/appinsights"
 should-deploy = true
 app-env = local.app_metadata.app_env
}

module "appgateway" {
 count = 1
 source = "./modules/appgateway"
 should-deploy = true
 app-env = local.app_metadata.app_env
}