module "incomings3" {
  source = "../../modules/s3bucket"

  bucket_name = var.bucket_name
  bucket_type = var.bucket_type
  env_name = var.env_name
}