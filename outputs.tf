# Main account bucket name.

output "security_group" {
  value       = aws_security_group.terraform_sg.id
  description = "Security Group ID."
}
