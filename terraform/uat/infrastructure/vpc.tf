module "vpc" {
  source = "../../modules/vpc"

  name        = var.env_name
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets
  azs             = var.vpc_azs
  cidr     = var.cidr
}
