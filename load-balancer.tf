module "nlb" {
  source             = "terraform-aws-modules/alb/aws"
  name               = "shrey-nlb"
  version            = "~> 8.0"
  load_balancer_type = "network"

  vpc_id   = aws_vpc.web-vpc.id
  subnets  = [aws_subnet.shrey-pvt-sub1.id, aws_subnet.shrey-pvt-sub2.id]
  internal = true

  target_groups = [
    {
      name_prefix      = "shrey-"
      backend_protocol = "TCP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = "${aws_instance.sub1-ec2.id}"
          port      = 80
        }
        my_other_target = {
          target_id = "${aws_instance.sub2-ec2.id}"
          port      = 80
        }
      }
    }
  ]

  http_tcp_listeners = [
    {
      port     = 80
      protocol = "TCP"
    }
  ]

  tags = {
    Name  = "shrey-nlb"
    Owner = "shrey.shah@intuitive.cloud"
  }
}

#---------------------------------------------------------------------

module "alb" {
  source                = "terraform-aws-modules/alb/aws"
  version               = "~> 8.0"
  load_balancer_type    = "application"
  name                  = "shrey-alb"
  vpc_id                = aws_vpc.web-vpc.id
  subnets               = [aws_subnet.shrey-pub-sub1.id, aws_subnet.shrey-pub-sub2.id]
  internal              = false
  create_security_group = false

  target_groups = [
    {
      name_prefix      = "shrey-"
      backend_protocol = "HTTP"
      stickiness       = { "enabled" = true, "type" = "lb_cookie" }
      peer_vpc_id      = "${aws_vpc.security-vpc.id}"
      backend_port     = 80
      target_type      = "ip"
      targets = {
        my_target = {
          availability_zone = "${aws_subnet.shrey-pvt-sub1.availability_zone}"
          target_id         = join("", data.aws_network_interface.ips.0.private_ips)
          port              = 80
        }
        my_other_target = {
          availability_zone = "${aws_subnet.shrey-pvt-sub2.availability_zone}"
          target_id         = join("", data.aws_network_interface.ips.1.private_ips)
          port              = 80
        }
      }
    }
  ]

  http_tcp_listeners = [
    {
      port     = 80
      protocol = "HTTP"
    }
  ]
}
