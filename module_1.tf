resource "aws_subnet" "pri_sub1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.az_1[0]
  tags = {
    Name = "(var.name)-Pri-Sub_1"
  }
}

resource "aws_route_table_association" "pri_rtbas1" {
  subnet_id      = aws_subnet.pri_sub1.id
  route_table_id = aws_route_table.pri_rtb1.id
}

resource "aws_route_table" "pri_rtb1" {
  vpc_id = aws_vpc.vpc1
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw1.id
  }
  tags = {
    Name = "(var.name)-Pri-Rtb_1"
  }
}

resource "aws_security_group" "pri_sg1" {
  name        = "(var.name)-SG_1"
  description = "Private Subnet Group"
  vpc_id      = aws_vpc.vpc1.id
  ingress {
    description = "Allowing all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allowing all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "instance1" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  tags = {
    Name = "(var.name)-Prv-Srv_1"
  }
}