module "sgs" {
  source = "../../modules/sgs"

  env_name        = var.env_name
  master_cidr     = var.cidr
  product_name    = var.product_name
}
