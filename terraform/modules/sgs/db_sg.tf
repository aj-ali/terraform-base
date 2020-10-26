variable "env_name" { }
variable "master_cidr" { }
variable "product_name" { }

data "aws_vpc" "selected" {
  filter {
    name = "tag:Name"
    values = ["${var.env_name}-vpc"]
  }
}

resource "aws_security_group" "db_sg" {
  name        = "${var.env_name}-${var.product_name}-db_sg"
  description = "SG for Database (SQL) instances"
  vpc_id      = data.aws_vpc.selected.id
ingress {
    description = "Allow SQL DB Access only for port 3306"
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["${var.master_cidr}"]
  }
egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.master_cidr}"]
  }
}
#--------- OUTPUTS FOR SECURITY GROUP ---------#
output "db_sg"{
  value = aws_security_group.db_sg
}