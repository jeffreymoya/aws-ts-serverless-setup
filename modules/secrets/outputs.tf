# Output the ARN of the Secrets Manager secret
output "db_secret_arn" {
  description = "The ARN of the Secrets Manager secret for database credentials"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

# Output the KMS key ARN used for encryption
output "kms_key_arn" {
  description = "The ARN of the KMS key used to encrypt the secret"
  value       = aws_kms_key.secrets_key.arn
}
