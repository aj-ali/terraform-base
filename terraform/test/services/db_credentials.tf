module "db_credentials" {
  source = "../../modules/db-secrets"

  db_username = var.db_username
  db_password = var.db_password
  name = "repairsense/mysql"
}