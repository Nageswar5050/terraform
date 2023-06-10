resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC_1"
  }
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "IGW_1"
  }
}

resource "aws_subnet" "pri_sub1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.az_1[0]
  tags = {
    Name = "Pri-Sub_1"
  }
}

resource "aws_security_group" "pri_sg1" {
  name        = "Pri_SG_1"
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

resource "aws_instance" "pri_instance1" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  tags = {
    Name = "Prv-Srv_1"
  }
}

resource "aws_subnet" "pub_sub1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.az_1[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "Pub-Sub_1"
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
    gateway_id = aws_internet_gateway.igw1.id
  }
  tags = {
    Name = "Pub-Rtb_1"
  }
}

resource "aws_security_group" "pub_sg1" {
  name        = "Pub-SG_1"
  description = "Public Subnet Group"
  vpc_id      = aws_vpc.vpc1.id
  ingress {
    description = "Allowing SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allowing ICMP"
    from_port   = "-1"
    to_port     = "-1"
    protocol    = "ICMP"
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
    Name = "Pub-Srv_1"
  }
  user_data = <<-EOF
  #!/bin/bash
  sudo apt-get update
  sudo apt-get install nginx -y
  sudo echo "You did it man, This is your instance id `curl http://169.254.169.254/latest/meta-data/instance-id`" >> /var/www/html/index.html
  sudo systemctl restart nginx
EOF
}