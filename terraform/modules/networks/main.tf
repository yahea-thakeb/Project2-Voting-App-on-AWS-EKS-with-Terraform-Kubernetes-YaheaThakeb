# --- VPC ---
resource "aws_vpc" "yahea_thakeb_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "yahea_thakebVPC"
  }
}

# --- Subnets ---
resource "aws_subnet" "yahea_thakeb_public_subnet" {
  vpc_id                  = aws_vpc.yahea_thakeb_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.subnet_availability_zone
  tags                    = { Name = "yahea_thakebPublicSubnet" }
}

resource "aws_subnet" "yahea_thakeb_public_subnet_a" {
  vpc_id                  = aws_vpc.yahea_thakeb_vpc.id
  cidr_block              = "10.0.11.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.subnet_availability_zone
  tags                    = { Name = "yahea_thakebPublicSubnetA" }
}

resource "aws_subnet" "yahea_thakeb_public_subnet_b" {
  vpc_id                  = aws_vpc.yahea_thakeb_vpc.id
  cidr_block              = "10.0.12.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.secondary_subnet_availability_zone
  tags                    = { Name = "yahea_thakebPublicSubnetB" }
}

resource "aws_subnet" "yahea_thakeb_private_subnet" {
  vpc_id                  = aws_vpc.yahea_thakeb_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.subnet_availability_zone
  tags                    = { Name = "yahea_thakebPrivateSubnetVote" }
}

resource "aws_subnet" "yahea_thakeb_private_subnet_a" {
  vpc_id                  = aws_vpc.yahea_thakeb_vpc.id
  cidr_block              = "10.0.21.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.subnet_availability_zone
  tags                    = { Name = "yahea_thakebPrivateSubnetVote" }
}

resource "aws_subnet" "yahea_thakeb_private_subnet_b" {
  vpc_id                  = aws_vpc.yahea_thakeb_vpc.id
  cidr_block              = "10.0.22.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.secondary_subnet_availability_zone
  tags                    = { Name = "yahea_thakebPrivateSubnetResult" }
}

# --- Internet Gateway + Route Tables ---
resource "aws_internet_gateway" "yahea_thakeb_igw" {
  vpc_id = aws_vpc.yahea_thakeb_vpc.id
  tags   = { Name = "yahea_thakebInternetGateway" }
}

resource "aws_route_table" "yahea_thakeb_public_rt" {
  vpc_id = aws_vpc.yahea_thakeb_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.yahea_thakeb_igw.id
  }
  tags = { Name = "public-route-table" }
}

resource "aws_route_table_association" "yahea_thakeb_public_rt_assoc" {
  subnet_id      = aws_subnet.yahea_thakeb_public_subnet.id
  route_table_id = aws_route_table.yahea_thakeb_public_rt.id
}

# --- Nat Gateway + Route Tables --- #

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.yahea_thakeb_public_subnet.id

  tags = {
    Name = "yahea_thakebNATGateway"
  }

  depends_on = [aws_internet_gateway.yahea_thakeb_igw]
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.yahea_thakeb_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "PrivateRouteTable"
  }
}

# --- Route Table Associations for private Instances --- #

resource "aws_route_table_association" "frontend_private_association" {
  subnet_id      = aws_subnet.yahea_thakeb_private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_a_assoc" {
  subnet_id      = aws_subnet.yahea_thakeb_private_subnet_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_b_assoc" {
  subnet_id      = aws_subnet.yahea_thakeb_private_subnet_b.id
  route_table_id = aws_route_table.private_rt.id
}

# --- Route Table Associations for public Instances --- #

resource "aws_route_table_association" "public_a_assoc" {
  subnet_id      = aws_subnet.yahea_thakeb_public_subnet_a.id
  route_table_id = aws_route_table.yahea_thakeb_public_rt.id
}

resource "aws_route_table_association" "public_b_assoc" {
  subnet_id      = aws_subnet.yahea_thakeb_public_subnet_b.id
  route_table_id = aws_route_table.yahea_thakeb_public_rt.id
}