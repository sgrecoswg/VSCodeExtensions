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

module "mainentry" {
  source        = "./modules"
  for_each      = { for region in local.active_regions : region.location => region }
  region       = each.value
  should-deploy = true
  app-env       = local.app_metadata.app_env
  app-name      = local.app_metadata.app_name
}