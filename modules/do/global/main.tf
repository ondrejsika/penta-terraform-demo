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
      ubuntu = "ubuntu-18-10-x64"
    }
    sizes = {
      small  = "s-1vcpu-1gb"
      medium = "s-2vcpu-2gb"
    }
  }
}
