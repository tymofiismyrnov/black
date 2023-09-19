# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "black_vpc"
  }
}

# Create a subnet in the VPC
resource "aws_subnet" "black_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "black_subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "black_gw"
  }
}

resource "aws_route_table" "black_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "black_route"
  }
}

resource "aws_route_table_association" "black_rt_association" {
  subnet_id      = aws_subnet.black_subnet.id
  route_table_id = aws_route_table.black_rt.id
}
