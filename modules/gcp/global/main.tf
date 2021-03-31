variable "name" {}
variable "default_ssh_key" {}


output "name" {
  value = var.name
}

output "conf" {
  value = {
    default_ssh_key = var.default_ssh_key
    images = {
      debian = "debian-cloud/debian-9"
    }
    sizes = {
      small = "f1-micro"
    }
  }
}
