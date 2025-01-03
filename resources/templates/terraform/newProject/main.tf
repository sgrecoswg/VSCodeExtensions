terraform {
  backend "remote" {
    organization = "sensibleprogramming"
    hostname     = "app.terraform.io"
    workspaces {
      prefix = "example-"
    }
  }
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
  features {
    # api_management {
    #   purge_soft_delete_on_destroy = true
    #   recover_soft_deleted         = true
    # }

    # app_configuration {
    #   purge_soft_delete_on_destroy = true
    #   recover_soft_deleted         = true
    # }

    # application_insights {
    #   disable_generated_rule = false
    # }

    # cognitive_account {
    #   purge_soft_delete_on_destroy = true
    # }

    # key_vault {
    #   purge_soft_delete_on_destroy    = true
    #   recover_soft_deleted_key_vaults = true
    # }

    # log_analytics_workspace {
    #   permanently_delete_on_destroy = true
    # }

    # machine_learning {
    #   purge_soft_deleted_workspace_on_destroy = true
    # }

    # managed_disk {
    #   expand_without_downtime = true
    # }

    # netapp {
    #   delete_backups_on_backup_vault_destroy = false
    #   prevent_volume_destruction             = true
    # }

    # postgresql_flexible_server {
    #   restart_server_on_configuration_value_change = true
    # }

    # recovery_service {
    #   vm_backup_stop_protection_and_retain_data_on_destroy = true
    #   purge_protected_items_from_vault_on_destroy          = true
    # }

    resource_group {
      prevent_deletion_if_contains_resources = false
    }

    # recovery_services_vault {
    #   recover_soft_deleted_backup_protected_vm = true
    # }

    # subscription {
    #   prevent_cancellation_on_destroy = false
    # }

    # template_deployment {
    #   delete_nested_items_during_deletion = true
    # }

    # virtual_machine {
    #   detach_implicit_data_disk_on_deletion = false
    #   delete_os_disk_on_deletion            = true
    #   graceful_shutdown                     = false
    #   skip_shutdown_and_force_delete        = false
    # }

    # virtual_machine_scale_set {
    #   force_delete                  = false
    #   roll_instances_when_required  = true
    #   scale_to_zero_before_deletion = true
    # }
  }
}

provider "infoblox" {

}

module "mainentry" {
  source        = "./modules"
  for_each      = { for region in local.active_regions : region.location => region }
  region        = each.value
  should-deploy = true
  app-env       = local.app_metadata.app_env
  app-name      = local.app_metadata.app_name

  #Gateway
  virtual-network-ip-set         = ["10.123.0.0/16"]
  virtual-subnet-ip-set          = ["10.123.1.0/24"]
  virtual-failover-subnet-ip-set = ["10.123.2.0/24"]
  gw-path                        = "/path1/"
  #appservice plan and service
  sku              = local.skus.F1
  os               = local.os.linux
  dotnet-framework = local.dotnetframework.4
  source-control   = local.sourcecontrol.LocalGit
  connection-string = {
    name  = "Database-${local.app_metadata.app_env}"
    type  = local.database.sql
    value = "Server=some-server-${local.app_metadata.app_env}.mydomain-.com;Integrated Security=SSPI"
  }
}