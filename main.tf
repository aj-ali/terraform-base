provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-and-running-state"
  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

#module "vpc" {
#  source = "../../"

#  name = "bjss-test-vpc"

#  cidr = "10.0.0.0/16"

#  azs             = ["eu-west-2a", "eu-west-2b"]
#  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
#  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

#  enable_ipv6 = true

#  enable_nat_gateway = true
#  single_nat_gateway = true

#  public_subnet_tags = {
#    Name = "overridden-name-public"
#  }

#  tags = {
#    Owner       = "user"
#    Environment = "dev"
#  }

#  vpc_tags = {
#    Name = "vpc-name"
#  }
#}


