locals {
  name = "Prod"
}

resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "(local.name)-VPC_1"
    }
}