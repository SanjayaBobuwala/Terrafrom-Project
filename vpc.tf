
#create VPC
resource "aws_vpc" "vpc" {
  cidr_block  = "${var.vpc-cidr}"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "Test VPC"
  }
}

#Create Internet Gatewat & attached it to VPC
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Test IGW"
  }
}

#create Public Subnet 1
resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.public-subnet-1-cidr}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1"
  }
}

#create Public Subnet 2
resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.public-subnet-2-cidr}"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 2"
  }
}

#create public route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.internet-gateway.id
    }

  tags = {
    Name = "Public Route Table"
  }
}

#associate public subnet 1 with public route table
resource "aws_route_table_association" "public-subnet-1-route-table-associate" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

#associate public subnet 2 with public route table
resource "aws_route_table_association" "public-subnet-2-route-table-associate" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}

#create private subnet 1
resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.private-subnet-1-cidr}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private subnet 1 | App Tier"
  }
}

#create private subnet 2
resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.private-subnet-2-cidr}"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private subnet 2 | App Tier"
  }
}

#create private subnet 3
resource "aws_subnet" "private-subnet-3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.private-subnet-3-cidr}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private subnet 3 | Database Tier"
  }
}

#create private subnet 4
resource "aws_subnet" "private-subnet-4" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.private-subnet-4-cidr}"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private subnet 4 | Database Tier"
  }
}

