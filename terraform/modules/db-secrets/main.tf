variable "name" {}
variable "db_username" {}
variable "db_password" {}

resource "aws_secretsmanager_secret" "secret" {
  description         = "Secret Values"
  name                = var.name
}

resource "aws_secretsmanager_secret_version" "secret" {
  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = <<EOF
{
  "db_username": "${var.db_username}",
  "db_password": "${var.db_password}",
}
EOF
}