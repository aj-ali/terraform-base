data "aws_vpc" "selected" {
  filter {
    name = "tag:Name"
    values = ["${var.env_name}-vpc"]
  }
}


data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = "${var.env_name}*private*"
  }
}

locals {
  subnet_ids_string = join(",", data.aws_subnet_ids.selected.ids)
  subnet_ids_list = split(",", local.subnet_ids_string)
}

resource "aws_ec2_client_vpn_endpoint" "default" {
  description            = "${var.env_name}-Client-VPN"
  server_certificate_arn = aws_acm_certificate.server.arn
  client_cidr_block      = var.vpn_cidr

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.root.arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.vpn.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn.name
  }

  tags = {
    Terraform = "true"
    Environment = var.env_name
  }
}

resource "aws_ec2_client_vpn_network_association" "default" {
  count                  = length(data.aws_subnet_ids.selected.ids)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  subnet_id              = element(local.subnet_ids_list, count.index)
}