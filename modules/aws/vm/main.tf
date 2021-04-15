variable "name" {}
variable "global" {}
variable "vpc" {}
variable "image" {}
variable "size" {}


resource "aws_instance" "main" {
  // Debian 10 AMI
  ami           = var.global.conf.images[var.image]
  instance_type = var.global.conf.sizes[var.size]
  key_name      = var.global.aws_key_pair.key_name
  security_groups = [
    var.global.aws_security_group.name
  ]
}

output "aws_instance" {
  value = aws_instance.main
}

output "public_ipv4_address" {
  value = aws_instance.main.public_ip
}

output "username" {
  value = "admin"
}

output "password" {
  value = null
}

