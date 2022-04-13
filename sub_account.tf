# Sub-account deployment.

resource "aws_security_group" "terraform_sg" {
  provider    = aws.cross-account
  name        = "Terraform-Cross-Account"
  description = "Test SG creation across accounts using Terraform."
  vpc_id      = "vpc-037792a989afc3b34"
}

resource "aws_iam_role" "container_worker_role" {
  provider = aws.cross-account
  name     = "ContainerWorker"

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

resource "aws_iam_instance_profile" "profile" {
  name = aws_iam_role.container_worker_role.name
  role = aws_iam_role.container_worker_role.name
}

resource "aws_instance" "instance" {
  provider             = aws.cross-account
  ami                  = "ami-0c02fb55956c7d316"
  instance_type        = "t2.micro"
  subnet_id            = "subnet-0f9d8707dbd8cd720"
  iam_instance_profile = aws_iam_instance_profile.profile.name
}
