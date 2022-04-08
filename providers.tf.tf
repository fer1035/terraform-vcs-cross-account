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
    # external_id  = "EXTERNAL-ID"
  }
}
