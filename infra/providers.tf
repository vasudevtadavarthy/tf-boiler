provider "aws" {
  region  = var.aws_region
  profile = "nexmo-dev"
  version = "2.70.0"
}