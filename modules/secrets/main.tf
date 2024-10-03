# Create a KMS Key for Secrets Encryption
resource "aws_kms_key" "secrets_key" {
  description = "KMS key for encrypting secrets in AWS Secrets Manager"

  tags = var.tags
}

# Create an AWS Secrets Manager secret for storing database credentials
resource "aws_secretsmanager_secret" "db_credentials" {
  name                    = var.db_secret_name
  kms_key_id              = aws_kms_key.secrets_key.arn
  description             = "Database credentials for the SaaS application"

  tags = var.tags
}

# Define a secret version with the actual database credentials
resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })

  lifecycle {
    ignore_changes = [secret_string]  # Prevents unnecessary updates
  }
}
