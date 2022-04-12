# Main account provider data.
provider "aws" {
  region     = var.region
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
  alias      = "cross-account"
  region     = var.region
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
    session_name = "terraform-cross-account"
    external_id  = var.aws_assumed_role_external_id
  }
}

# Main account intrinsic variables.
data "aws_caller_identity" "main" {}
data "aws_region" "main" {}
locals {
  main_account_id = data.aws_caller_identity.main.account_id
  main_region     = data.aws_region.main.name
}

# Sub-account intrinsic variables.
data "aws_caller_identity" "sub" {
  provider = aws.cross-account
}
data "aws_region" "sub" {
  provider = aws.cross-account
}
locals {
  sub_account_id = data.aws_caller_identity.sub.account_id
  sub_region     = data.aws_region.sub.name
}
