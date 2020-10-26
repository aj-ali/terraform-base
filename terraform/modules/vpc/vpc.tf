
variable "env_name" {}
variable "azs" {}
variable "private_subnets" {}
variable "public_subnets" {}
variable "master_cidr" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.env_name}-vpc"
  cidr = "${var.master_cidr}"

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = var.env_name
  }
}