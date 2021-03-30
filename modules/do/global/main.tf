variable "name" {}
variable "region" {}

output "name" {
  value = var.name
}

output "conf" {
  value = {
    region = var.region
    images = {
      debian = "debian-10-x64"
    }
    sizes = {
      small = "s-1vcpu-1gb"
    }
  }
}
