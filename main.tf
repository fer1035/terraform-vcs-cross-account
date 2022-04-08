# Updated: Tue Apr  5 16:28:09 +08 2022

# Intrinsic variables.
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}

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

# Tags variables.
variable "tag_Name" {
  type        = string
  default     = "Terraform Cross-Account Test"
  description = "Name tag."
}
variable "tag_sitecode" {
  type        = string
  default     = "123"
  description = "Site code tag."
}
variable "tag_department" {
  type        = string
  default     = "CuriousCats"
  description = "Department tag."
}
variable "tag_team" {
  type        = string
  default     = "myteam@mycompany.com"
  description = "Team tag."
}
variable "tag_tier" {
  type        = string
  default     = "dev"
  description = "Tier tag."
}
variable "tag_costcenter" {
  type        = string
  default     = "9999"
  description = "Cost center tag."
}

# Main account provider data.
provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  default_tags {
    tags = {
      Name       = var.tag_Name
      sitecode   = var.tag_sitecode
      department = var.tag_department
      team       = var.tag_team
      tier       = var.tag_tier
      costcenter = var.tag_costcenter
    }
  }
}

# Sub-account provider data.
provider "aws" {
  alias   = "cross-account"
  region     = "us-east-1"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  default_tags {
    tags = {
      Name       = var.tag_Name
      sitecode   = var.tag_sitecode
      department = var.tag_department
      team       = var.tag_team
      tier       = var.tag_tier
      costcenter = var.tag_costcenter
    }
  }
  assume_role {
    role_arn     = var.aws_assumed_role_arn
    session_name = "terraform-cross-account-test"
  }
}

# Main account deployment.
resource "aws_s3_bucket" "main" {
  bucket = "mybucket-${local.account_id}-${local.region}"
}
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
  bucket   = "mybucket-${local.account_id}-${local.region}"
}
resource "aws_s3_bucket_acl" "sub" {
  provider = aws.cross-account
  bucket   = aws_s3_bucket.sub.id
  acl      = "private"
}
output "sub_bucket_name" {
  value       = aws_s3_bucket.sub.id
  description = "Sub-account S3 bucket name."
}
