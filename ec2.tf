resource "aws_instance" "sub1-ec2" {
  ami             = data.aws_ami.ami.id
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.main.id
  security_groups = [aws_security_group.web-sg.id]

  tags = {
    Name = "Shrey-ec2-1"
  }

}

resource "aws_instance" "sub2-ec2" {
  ami             = data.aws_ami.ami.id
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.main.id
  security_groups = [aws_security_group.web-sg.id]
  tags = {
    Name = "Shrey-ec2-2"
  }

}
