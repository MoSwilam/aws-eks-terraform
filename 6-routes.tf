resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${local.env}-private-rt"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${local.env}-public-rt"
  }
}

resource "aws_route_table_association" "private_zone1_association" {
  subnet_id      = aws_subnet.private_zone1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_zone2_association" {
  subnet_id      = aws_subnet.private_zone2.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "public_zone1_association" {
  subnet_id      = aws_subnet.public_zone1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_zone2_association" {
  subnet_id      = aws_subnet.public_zone2.id
  route_table_id = aws_route_table.public_route_table.id
}