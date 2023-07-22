resource "aws_vpc" "security-vpc" {
  cidr_block = "10.0.0.0/18"
  tags = {
    Name = "shrey-sec-vpc"
  }
}

resource "aws_vpc" "web-vpc" {
  cidr_block = "10.0.64.0/18"
  tags = {
    Name = "shrey-web-vpc"
  }
}

resource "aws_subnet" "shrey-pvt-sub1" {
  vpc_id            = aws_vpc.web-vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.64.0/24"
  tags = {
    Name = "shrey-pvt-sub1"
  }
}

resource "aws_subnet" "shrey-pvt-sub2" {
  vpc_id            = aws_vpc.web-vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.65.0/24"
  tags = {
    Name = "shrey-pvt-sub2"
  }
}

resource "aws_subnet" "shrey-pub-sub1" {
  vpc_id            = aws_vpc.security-vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "shrey-pub-sub1"
  }
}

resource "aws_subnet" "shrey-pub-sub2" {
  vpc_id            = aws_vpc.security-vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "shrey-pub-sub2"
  }
}
