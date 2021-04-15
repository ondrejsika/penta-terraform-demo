variable "name" {}
variable "default_ssh_key" {}


output "name" {
  value = var.name
}

resource "aws_key_pair" "default" {
  key_name   = "default"
  public_key = var.default_ssh_key
}

resource "aws_security_group" "default" {
  name = "default_allow_all"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "conf" {
  value = {
    images = {
      debian = "ami-0245697ee3e07e755"
    }
    sizes = {
      small = "t2.micro"
    }
  }
}

output "aws_key_pair" {
  value = aws_key_pair.default
}

output "aws_security_group" {
  value = aws_security_group.default
}
