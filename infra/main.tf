module "vasudev-test" {
  source = "../modules/s3"
  aws_region = var.aws_region
  bucket_name = var.bucket_name
  bucket_env = var.bucket_env
}

