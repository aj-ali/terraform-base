variable alloc_store {}
variable store_type {}
variable engine {}
variable engine_ver {}
variable inst_type {}
variable db_name {}
variable db_username {}
variable db_password {}
variable "env_name" {}
variable "product_name" {}
variable "db_sg" {}

data "aws_vpc" "selected" {
  filter {
    name = "tag:Name"
    values = ["${var.env_name}-vpc"]
  }
}

data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Environment = var.env_name
  }
}

resource "aws_db_subnet_group" "dbsubnet" {
  name       = "${var.env_name}-db-subnet-group"
  subnet_ids = data.aws_subnet_ids.selected.ids
  depends_on        = [var.db_sg]
}

resource "aws_db_instance" "rds_inst" {
  depends_on = [aws_db_subnet_group.dbsubnet]
  allocated_storage = var.alloc_store # Storage size for DB
  storage_type      = var.store_type #Storage type of DB
  engine = var.engine # Type of DB Engine (Eg: mysql, mariadb)
  vpc_security_group_ids = [var.db_sg.id]
  engine_version         = var.engine_ver
  instance_class         = var.inst_type #DB instance type (Eg: db.t2.micro)
  db_subnet_group_name   = "${var.env_name}-db-subnet-group"
  # Giving Credentials for the DB table and user access
  name                 = "${var.env_name}${var.product_name}${var.db_name}"
  username             = var.db_username
  password             = var.db_password

  publicly_accessible = false
  skip_final_snapshot = true
  storage_encrypted    = true
tags = {
    Terraform = "true"
    Environment = var.env_name
    Name = "${var.env_name}-${var.product_name}-${var.db_name}"
  }
}
#--------- OUTPUTS FOR RDS DATABASE ---------#
# Gives DB table name
output "db_name" {
  value = aws_db_instance.rds_inst.name
}
# Gives the DB host address
output "db_addr" {
  value = aws_db_instance.rds_inst.address
}
# Gives the username for DB access
output "db_username" {
  value = aws_db_instance.rds_inst.username
}
# Gives the password for DB access
output "db_passwd" {
  value = aws_db_instance.rds_inst.password
}