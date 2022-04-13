# Sub-account deployment.

resource "aws_security_group" "terraform_sg" {
  provider    = aws.cross-account
  name        = "Terraform-Cross-Account"
  description = "Test SG creation across accounts using Terraform."
  vpc_id      = "vpc-037792a989afc3b34"
}

resource "aws_iam_role" "container_worker_role" {
  name = "ContainerWorker"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "ContainerWorker"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}
