provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-state2222"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-2"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

