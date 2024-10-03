# Output the main SQS Queue URL
output "sqs_queue_url" {
  description = "The URL of the main SQS queue"
  value       = aws_sqs_queue.main_queue.id
}

# Output the Dead Letter Queue (DLQ) URL
output "sqs_dlq_url" {
  description = "The URL of the Dead Letter Queue"
  value       = aws_sqs_queue.dlq_queue.id
}

# Output the Lambda permission statement ID
output "lambda_permission_statement_id" {
  description = "The statement ID of the Lambda permission"
  value       = aws_lambda_permission.allow_sqs_invoke.statement_id
}
