# Main account bucket name.
output "main_bucket_name" {
  value       = aws_s3_bucket.main.id
  description = "Main account S3 bucket name."
}

# Sub-account bucket name.
output "sub_bucket_name" {
  value       = aws_s3_bucket.sub.id
  description = "Sub-account S3 bucket name."
}
