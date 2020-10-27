terraform {
  backend "s3" {
    bucket         = "terraform-state2224"
    key            = "global/s3/test-terraform-infrastructure.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-running"
    encrypt        = true
  }
}
