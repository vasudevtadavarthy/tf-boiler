resource "aws_s3_bucket" "bucket-vasudev" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = var.bucket_env
  }
}

