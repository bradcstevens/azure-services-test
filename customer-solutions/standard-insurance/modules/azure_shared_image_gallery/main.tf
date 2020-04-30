provider "azurerm" {
}
resource "azurerm_resource_group" "sig" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}
resource "azurerm_shared_image_gallery" "sig" {
  name                = "${var.gallery_name}"
  resource_group_name = "${azurerm_resource_group.sig.name}"
  location            = "${azurerm_resource_group.sig.location}"
  description         = "Shared images and things."

  tags = {
    Owner = "${var.owner_tag}"
    Environment = "${var.environment_tag}"
  }
}