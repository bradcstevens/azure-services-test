 # locate the existing custom/golden image
data "azurerm_image" "search" {
    name                = "${var.managed_image_name}"
    resource_group_name = "${var.managed_image_resource_group}"
}

output "image_id" {
  value = "${data.azurerm_image.search.id}"
}

resource "azurerm_resource_group" "rg" {
    name     = "${var.resource_group_name}"
    location = "${var.location}"

    tags = {
        Owner       = "${var.tag_owner}"
        Environment = "${var.tag_environment}"
    }
}

resource "azurerm_virtual_network" "vnet" {
    name                = "${var.virtual_network_name}"
    location            = "${var.location}"
    address_space       = ["${var.address_space}"]
    resource_group_name = "${azurerm_resource_group.rg.name}"

    tags = {
        Owner       = "${var.tag_owner}"
        Environment = "${var.tag_environment}"
    }
}

resource "azurerm_subnet" "subnet" {
    name                 = "${var.subnet_name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    address_prefix       = "${var.subnet_prefix}"
}

resource "azurerm_network_security_group" "nsg" {
    name                = "${var.virtual_network_name}Nsg01"
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"

    security_rule {
        name                       = "allow_SSH"
        description                = "Allow SSH access"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "allow_RDP"
        description                = "Allow RDP access"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        Owner       = "${var.tag_owner}"
        Environment = "${var.tag_environment}"
    }
}

resource "azurerm_public_ip" "pip" {
    name                = "${var.vm_name}Nic01Pip01"
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    allocation_method   = "Dynamic"

    tags = {
        Owner       = "${var.tag_owner}"
        Environment = "${var.tag_environment}"
    }
}

resource "azurerm_network_interface" "nic" {
    name                      = "${var.vm_name}Nic01"
    location                  = "${var.location}"
    resource_group_name       = "${azurerm_resource_group.rg.name}"
    network_security_group_id = "${azurerm_network_security_group.nsg.id}"

    ip_configuration {
        name                          = "ipconfig01"
        subnet_id                     = "${azurerm_subnet.subnet.id}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "${azurerm_public_ip.pip.id}"
    }

    tags = {
        Owner       = "${var.tag_owner}"
        Environment = "${var.tag_environment}"
    }
}

resource "azurerm_virtual_machine" "vm" {
    name                  = "${var.vm_name}"
    location              = "${var.location}"
    resource_group_name   = "${azurerm_resource_group.rg.name}"
    network_interface_ids = ["${azurerm_network_interface.nic.id}"]
    vm_size               = "${var.vm_size}"

    storage_image_reference {
        id = "${data.azurerm_image.search.id}"
    }

    storage_os_disk {
        name          = "${var.vm_name}OsDisk01"
        caching       = "ReadWrite"
        create_option = "FromImage"
    }
    
    storage_data_disk {
        name              = "${var.vm_name}Data01"
        managed_disk_type = "Premium_LRS"
        create_option     = "Empty"
        lun               = 0
        disk_size_gb      = "1024"
  }

    os_profile {
        computer_name  = "${var.hostname}"
        admin_username = "${var.admin_username}"
        admin_password = "${var.admin_password}"
    }

    os_profile_windows_config {

    }

    tags = {
        Owner       = "${var.tag_owner}"
        Environment = "${var.tag_environment}"
    }
}
