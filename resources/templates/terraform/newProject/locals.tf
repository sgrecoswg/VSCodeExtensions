locals {
    app_metadata = {
        app_env = var.app_env
    }

    regions = [
        {
            location = "centralus"
        },
        {
            location = "easteus2"
        }
    ]
}