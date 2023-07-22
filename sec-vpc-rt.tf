resource "aws_route_table" "sec-vpc-rt" {
  vpc_id = aws_vpc.security-vpc.id
  tags = {
    "Name" = "shrey-sec-rt"
  }
}

resource "aws_route" "igw" {
  route_table_id         = aws_route_table.sec-vpc-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "vpc-peer-sec" {
  route_table_id            = aws_route_table.sec-vpc-rt.id
  destination_cidr_block    = "10.0.64.0/18"
  vpc_peering_connection_id = aws_vpc_peering_connection.web-sec-peering.id
}

resource "aws_route_table_association" "shrey-pub-sub1-rt" {
  subnet_id      = aws_subnet.shrey-pub-sub1.id
  route_table_id = aws_route_table.sec-vpc-rt.id
}

resource "aws_route_table_association" "shrey-pub-sub2-rt" {
  subnet_id      = aws_subnet.shrey-pub-sub2.id
  route_table_id = aws_route_table.sec-vpc-rt.id
}
