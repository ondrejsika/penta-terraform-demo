variable "name" {}
variable "global" {}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

output "aws_vpc" {
  value = aws_vpc.main
}

