variable "name" {}
variable "global" {}

resource "azurerm_virtual_network" "main" {
  name                = var.name
  address_space       = ["10.120.0.0/16"]
  location            = var.global.azurerm_resource_group.location
  resource_group_name = var.global.azurerm_resource_group.name
}

resource "azurerm_subnet" "main" {
  name                 = var.name
  resource_group_name  = var.global.azurerm_resource_group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.120.0.0/24"]
}

output "azurerm_virtual_network" {
  value = azurerm_virtual_network.main
}

output "azurerm_subnet" {
  value = azurerm_subnet.main
}
