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

resource "digitalocean_droplet" "main" {
  name      = var.name
  size      = var.global.conf.sizes[var.size]
  image     = var.global.conf.images[var.image]
  region    = var.global.conf.region
  vpc_uuid  = var.vpc.digitalocean_vpc.id
  user_data = <<EOF
#cloud-config
ssh_pwauth: yes
password: ${random_password.root.result}
chpasswd:
  expire: false
EOF
}

output "digitalocean_droplet" {
  value = digitalocean_droplet.main
}

output "public_ipv4_address" {
  value = digitalocean_droplet.main.ipv4_address
}

output "username" {
  value = "root"
}

output "password" {
  value = random_password.root.result
}

