# Sub-account deployment.

resource "aws_security_group" "terraform_sg" {
  provider    = aws.cross-account
  name        = "Terraform-Cross-Account"
  description = "Test SG creation across accounts using Terraform."
}
