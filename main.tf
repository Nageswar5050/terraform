resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "(var.name)-VPC_1"
  }
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "(var.name)-IGW_1"
  }
}

resource "aws_nat_gateway" "ngw1" {
  subnet_id = aws_subnet.pri_sub1.id
  tags = {
    Name = "(var.name)-NGW_1"
  }
}