variable "bucket_name" {}
variable "bucket_type" {}
variable "env_name" {}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = var.bucket_type

  tags = {
    Terraform = "true"
    Environment = var.env_name
    Name = "${var.env_name}-${var.bucket_name}"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}