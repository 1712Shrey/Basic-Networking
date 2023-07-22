resource "aws_vpc_peering_connection" "web-sec-peering" {
  peer_vpc_id = aws_vpc.web-vpc.id
  vpc_id      = aws_vpc.security-vpc.id
  auto_accept = true

  tags = {
    Name = "shrey-peering"
  }
}
