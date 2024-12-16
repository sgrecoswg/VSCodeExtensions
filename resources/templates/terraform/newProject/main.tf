terraform {
    backend "remote" {
        organization = "|organization|"
        hostname = "app.terraform.io"
        workspaces {
            prefix = "|workspaceprefix|"
        }
    }
}

provider "azurerm" {
    features {}
}

provider "infoblox" {
 
}