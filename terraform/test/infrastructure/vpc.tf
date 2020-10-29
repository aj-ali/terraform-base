module "vpc" {
  source = "../../modules/vpc"

  env_name        = var.env_name
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets
  azs             = var.vpc_azs
  master_cidr     = var.cidr
}