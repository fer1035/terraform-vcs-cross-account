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
