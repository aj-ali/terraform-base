resource "aws_cloudwatch_log_group" "vpn" {
  name              = "/aws/vpn/${var.env_name}/logs"
  retention_in_days = var.logs_retention

  tags = {
    Terraform = "true"
    Environment = var.env_name
  }
}

resource "aws_cloudwatch_log_stream" "vpn" {
  name           = "vpn-usage"
  log_group_name = aws_cloudwatch_log_group.vpn.name
}
