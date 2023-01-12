module "s3_1" {
  source         = "./modules/s3"
  s3_bucket_name = var.s3_bucket_name
}
