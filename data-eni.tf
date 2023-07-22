data "aws_network_interfaces" "eni" {
  filter {
    name   = "description"
    values = ["ELB net/shrey-nlb/*"]
  }

  filter {
    name   = "vpc-id"
    values = ["${aws_vpc.web-vpc.id}"]
  }

  filter {
    name   = "status"
    values = ["in-use"]
  }

  filter {
    name   = "attachment.status"
    values = ["attached"]
  }
}

locals {
  nlb_interface_ids = flatten(["${data.aws_network_interfaces.eni.ids}"])
}

data "aws_network_interface" "ips" {
  count = 2
  id    = local.nlb_interface_ids[count.index]
}

output "aws_lb_network_interface_ips" {
  value = join("", data.aws_network_interface.ips.0.private_ips)
}

