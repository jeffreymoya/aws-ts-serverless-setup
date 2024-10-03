# Variable for the AWS Secrets Manager secret name
variable "db_secret_name" {
  description = "The name of the Secrets Manager secret for storing database credentials"
  type        = string
}

# Variable for the database username
variable "db_username" {
  description = "The database username to store in the secret"
  type        = string
}

# Variable for the database password
variable "db_password" {
  description = "The database password to store in the secret"
  type        = string
}

# Tags to apply to the resources
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
