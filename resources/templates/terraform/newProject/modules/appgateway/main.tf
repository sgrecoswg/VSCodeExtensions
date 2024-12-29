resource "azurerm_virtual_network" "n" {
  name                = "vnetwork-${var.app-name}-${var.app-env}-${var.region}"
  resource_group_name = var.rg-name
  location            = var.rg-location
  address_space       = var.virtual-network-ip-set

  tags = {
    environment = var.app-env
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-${var.app-name}-${var.app-env}-${var.region}"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.n.name
  address_prefixes     = var.virtual-subnet-ip-set
}

resource "azurerm_subnet" "failoversubnet" {
  name = "failoversubnet-${var.app-name}-${var.app-env}-${var.region}"
  resource_group_name = var.rg-name
  virtual_network_name = azurerm_virtual_network.n.name
  address_prefixes = var.virtual-failover-subnet-ip-set
}

#Get a public IP
resource "azurerm_public_ip" "pip" {
  name                = "pip-${var.app-name}-${var.app-env}-${var.region}"
  resource_group_name = var.rg-name
  location            = var.rg-location
  allocation_method   = "Static"

  tags = {
    environment = var.app-env
  }
}

resource "azurerm_application_gateway" "gw" {
  count    = var.should-deploy ? 1 : 0
  name                = "gw-${var.app-name}-${var.app-env}-${var.region}"
  resource_group_name = var.rg-name
  location            = var.rg-location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gw-${var.app-name}-${var.app-env}-${var.region}-ip-configuration"
    subnet_id = azurerm_subnet.subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = var.gw-path 
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}

# Create a subnet named as "AzureBastionSubnet" in the Virtual Network for creating Azure Bastion