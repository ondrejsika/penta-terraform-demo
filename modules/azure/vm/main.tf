variable "name" {}
variable "global" {}
variable "vpc" {}
variable "image" {}
variable "size" {}

resource "random_password" "root" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "azurerm_public_ip" "main" {
  name                = var.name
  location            = var.global.azurerm_resource_group.location
  resource_group_name = var.global.azurerm_resource_group.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "main" {
  name                = var.name
  location            = var.global.azurerm_resource_group.location
  resource_group_name = var.global.azurerm_resource_group.name
  ip_configuration {
    name                          = "network0"
    subnet_id                     = var.vpc.azurerm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = var.name
  location              = var.global.azurerm_resource_group.location
  resource_group_name   = var.global.azurerm_resource_group.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_A2_v2"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = var.name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.name
    admin_username = "default"
    admin_password = random_password.root.result
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

output "azurerm_virtual_machine" {
  value = azurerm_virtual_machine.main
}

output "public_ipv4_address" {
  value = azurerm_public_ip.main.ip_address
}

output "username" {
  value = element(tolist(azurerm_virtual_machine.main.os_profile), 0).admin_username
}

output "password" {
  value = random_password.root.result
}
