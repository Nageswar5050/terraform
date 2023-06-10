resource "aws_subnet" "pub_sub1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.az_1[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "(var.name)-Pub-Sub_1"
  }
}

resource "aws_route_table_association" "pub_rtbas1" {
  subnet_id      = aws_subnet.pub_sub1.id
  route_table_id = aws_route_table.pub_rtb1.id
}

resource "aws_route_table" "pub_rtb1" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw1.id
  }
  tags = {
    Name = "(var.name)-Pub-Rtb_1"
  }
}

resource "aws_security_group" "pub_sg1" {
  name        = "(var.name)-Pub-SG_1"
  description = "Public Subnet Group"
  vpc_id      = aws_vpc.vpc1.id
  ingress {
    description = "Allowing SSH"
    from_port   = 0
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "Allowing ICMP"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }

   ingress {
    description = "Allowing HTTP"
    from_port   = "80"
    to_port     = "80"
    protocol    = "TCP"
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

resource "aws_instance" "pub_instance1" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  tags = {
    Name = "(var.name)-Pub-Srv_1"
  }
}