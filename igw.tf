resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.security-vpc.id
  tags = {
    "Name" = "shrey-igw"
  }
}
