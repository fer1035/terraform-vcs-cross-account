# Updated: Tue Apr  5 16:28:09 +08 2022

# Credentials variables.
variable "aws_access_key_id" {
  type      = string
  sensitive = true
}
variable "aws_secret_access_key" {
  type      = string
  sensitive = true
}
variable "aws_assumed_role_arn" {
  type      = string
  sensitive = true
}

# Main account provider data.
provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  default_tags {
    tags = {
      Name       = "Terraform Cross-Account Test"
      sitecode   = "123"
      department = "CuriousCats"
      team       = "myteam@mycompany.com"
      tier       = "dev"
      costcenter = "1234"
    }
  }
}

# Sub-account provider data.
provider "aws" {
  alias   = "cross-account"
  region     = "us-east-1"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  assume_role {
    role_arn     = var.aws_assumed_role_arn
    session_name = "terraform-cross-account-test"
  }
}

# Main account deployment.
resource "aws_s3_bucket" "main" {}
resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket.main.id
  acl    = "private"
}
output "main_bucket_name" {
  value       = aws_s3_bucket.main.id
  description = "Main account S3 bucket name."
}

# Sub-account deployment.
resource "aws_s3_bucket" "sub" {
  provider = aws.cross-account
}
resource "aws_s3_bucket_acl" "sub" {
  provider = aws.cross-account
  bucket   = aws_s3_bucket.sub.id
  acl      = "private"
}
output "sub_bucket_name" {
  provider    = aws.cross-account
  value       = aws_s3_bucket.sub.id
  description = "Sub-account S3 bucket name."
}
