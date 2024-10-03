# Create a KMS Key for Secrets Encryption
resource "aws_kms_key" "secrets_key" {
  description = "KMS key for encrypting secrets in AWS Secrets Manager"
}

# Store a Secret in AWS Secrets Manager
resource "aws_secretsmanager_secret" "database_credentials" {
  name                    = "db_credentials"
  kms_key_id              = aws_kms_key.secrets_key.arn
  description             = "Database credentials for the SaaS application"
}

resource "aws_secretsmanager_secret_version" "database_credentials_version" {
  secret_id     = aws_secretsmanager_secret.database_credentials.id
  secret_string = jsonencode({
    username = "admin",
    password = "admin"
  })
}
