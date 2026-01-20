resource "aws_vpc" "s_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.s_vpc.id

  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.s_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.env}-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.s_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-public-subnet"
  }
}
