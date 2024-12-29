locals {
    app_metadata = {
        app_env = var.app_env
        app_name = "samplepp"
    }

    regions = [
        {
            active   = true
            location = "centralus"
        },
        {
            active   = true
            location = "eastus2"
        }
    ]

     active_regions = [for region in local.regions : region if region.active]
}