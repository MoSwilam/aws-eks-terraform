resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name = "${local.env}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_zone1.id

  tags = {
    Name = "${local.env}-nat"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}