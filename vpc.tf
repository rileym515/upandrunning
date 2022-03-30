resource "aws_vpc" "terra1" {
  cidr_block       = "10.5.4.0/24"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "terra1"
    Owner = "yournamehere"
  }
}


# The primary Internet Gateway for the VPC
resource "aws_internet_gateway" "terra1" {
  vpc_id = aws_vpc.terra1.id
  tags = {
    Name = "terra1"
    Owner = "yournamehere"
  }

}

resource "aws_subnet" "terra1_b" {
  vpc_id                  = aws_vpc.terra1.id
  cidr_block              = "10.5.4.64/26"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "terra1"
    Owner = "yournamehere"
  }

}

resource "aws_route_table" "terra1_public" {
  vpc_id = aws_vpc.terra1.id
  tags = {
    Name = "terra1"
    Owner = "yournamehere"
  }

}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.terra1_b.id
  route_table_id = aws_route_table.terra1_public.id
}

# Default route to the Internet via the VPC internet gateway
resource "aws_route" "terra1_public_internet_via_igw" {
  route_table_id         = aws_route_table.terra1_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terra1.id
}
