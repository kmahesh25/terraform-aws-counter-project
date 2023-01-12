module "iam_role_1" {
  source        = "./modules/iam_role"
  role_name     = var.iam_role_name
  s3_bucket_arn = local.s3_bucket_arn
}
