#terraform {
#  backend "s3" {
#    bucket         = "terraform-state2223"
#    key            = "global/s3/dev-terraform-infrastructure.tfstate"
#    region         = "eu-west-2"
#    dynamodb_table = "terraform-running"
#    encrypt        = true
#  }
#}
