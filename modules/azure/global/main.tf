variable "name" {}
variable "location" {}

output "name" {
  value = var.name
}

resource "azurerm_resource_group" "main" {
  name     = var.name
  location = var.location
}

output "conf" {
  value = {
    region = "fra1"
    images = {
      debian = "debian-10-x64"
    }
    sizes = {
      small = "s-1vcpu-1gb"
    }
  }
}

output "azurerm_resource_group" {
  value = azurerm_resource_group.main
}
