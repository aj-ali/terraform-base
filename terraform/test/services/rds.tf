module "rds" {
  source = "../../modules/rds"

  alloc_store = var.alloc_store
  store_type = var.store_type
  engine = var.engine
  engine_ver = var.engine_ver
  inst_type = var.inst_type
  db_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  env_name = var.env_name
  product_name = var.product_name
  db_sg = module.sgs.db_sg
}