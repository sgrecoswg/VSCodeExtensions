locals {
  app_metadata = {
    app_env  = var.app_env
    app_name = "samplepp"
  }

  regions = [
    {
      active   = true
      location = "CentralUS"
    },
    {
      active   = false
      location = "EastUS"
    }
  ]

  active_regions = [for region in local.regions : region if region.active]

  skus = {
    F1 = "F1" #free
    S1 = "S1"
  }

  os = {
    linux   = "Linux"
    windows = "Windows"
  }

  dotnetframework = {
    4 = "v4.0"
  }

  sourcecontrol = {
    LocalGit = "LocalGit"
  }

  database = {
    sql  = "SQLServer"
  }
}