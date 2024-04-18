terraform {
  required_version = ">= 1.4.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">= 5.0.0"
    }
  }
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = 2
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = element(var.public_subnet_ips, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = 2
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = element(var.private_subnet_ips, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "private-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnets[*].id, 0)

  tags = {
    Name = "nat-gateway"
  }
}

resource "aws_eip" "nat_eip" {
  #   vpc = true

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}


