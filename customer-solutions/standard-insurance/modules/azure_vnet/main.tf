provider "azurerm" {

}

resource "azurerm_resource_group" "rg" {
    name     = "${var.hub_resource_group_name}"
    location = "${var.hub_location}"

    tags = {
        Owner       = "${var.tag_owner}"
        Environment = "${var.tag_environment}"
    }
}

resource "azurerm_virtual_network" "vnet" {
    name                = "${var.hub_virtual_network_name}"
    location            = "${var.hub_location}"
    address_space       = ["${var.hub_address_space}"]
    resource_group_name = "${azurerm_resource_group.rg.name}"

    tags = {
        Owner       = "${var.tag_owner}"
        Environment = "${var.tag_environment}"
    }
}

resource "azurerm_subnet" "hub_gateway_subnet" {
    name                 = "${var.hub_gateway_subnet_name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    address_prefix       = "${var.hub_gateway_subnet_prefix}"
}

resource "azurerm_subnet" "hub_subnet_1" {
    name                 = "${var.hub_subnet_1_name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    address_prefix       = "${var.hub_subnet_1_prefix}"
}

resource "azurerm_subnet" "hub_subnet_2" {
    name                 = "${var.hub_subnet_2_name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    address_prefix       = "${var.hub_subnet_2_prefix}"
}

resource "azurerm_subnet" "hub_subnet_3" {
    name                 = "${var.hub_subnet_3_name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    address_prefix       = "${var.hub_subnet_3_prefix}"
}

resource "azurerm_subnet" "hub_subnet_4" {
    name                 = "${var.hub_subnet_4_name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    address_prefix       = "${var.hub_subnet_4_prefix}"
}

resource "azurerm_subnet" "hub_subnet_5" {
    name                 = "${var.hub_subnet_5_name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    address_prefix       = "${var.hub_subnet_5_prefix}"
}
# Virtual Network Gateway
resource "azurerm_public_ip" "hub_gateway_1_pip" {
  name                = "${var.hub_gateway_1_pip}"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "hub_gateway_1" {
  name                = "${var.hub_gateway_1}"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = "${azurerm_public_ip.hub_gateway_1_pip.id}"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "${azurerm_subnet.hub_gateway_subnet.id}"
  }
  depends_on = ["azurerm_public_ip.hub_gateway_1_pip"]
}