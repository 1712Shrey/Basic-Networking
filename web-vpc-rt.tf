resource "aws_route_table" "web-vpc-rt" {
  vpc_id = aws_vpc.web-vpc.id
  tags = {
    "Name" = "shrey-web-rt"
  }
}

resource "aws_route" "vpc-peer-web" {
  route_table_id            = aws_route_table.web-vpc-rt.id
  destination_cidr_block    = "10.0.0.0/18"
  vpc_peering_connection_id = aws_vpc_peering_connection.web-sec-peering.id
}

resource "aws_route_table_association" "shrey-pvt-sub1-rt" {
  subnet_id      = aws_subnet.shrey-pvt-sub1.id
  route_table_id = aws_route_table.web-vpc-rt.id
}

resource "aws_route_table_association" "shrey-pvt-sub2-rt" {
  subnet_id      = aws_subnet.shrey-pvt-sub2.id
  route_table_id = aws_route_table.web-vpc-rt.id
}
