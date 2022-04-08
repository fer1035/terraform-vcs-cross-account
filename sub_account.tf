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
