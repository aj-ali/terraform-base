
module "client_vpn" {
  source = "../../modules/client-vpn"

  env_name = var.env_name
  vpn_cidr = var.vpn_cidr
  organisation_name = var.organisation_name
  logs_retention = var.logs_retention

}