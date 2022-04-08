# Main account deployment.

resource "aws_s3_bucket" "main" {
  bucket = "mybucket-${local.main_account_id}-${local.main_region}"
}

resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket.main.id
  acl    = "private"
}
