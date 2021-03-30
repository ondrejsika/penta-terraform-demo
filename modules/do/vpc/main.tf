variable "name" {}
variable "global" {}

resource "digitalocean_vpc" "main" {
  name   = var.name
  region = var.global.conf.region
  // ip_range = "10.10.10.0/24"
}

output "digitalocean_vpc" {
  value = digitalocean_vpc.main
}

