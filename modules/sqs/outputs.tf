output "sqs_queue_url" {
  description = "The URL of the main SQS queue"
  value       = aws_sqs_queue.main_queue.id
}

output "sqs_dlq_url" {
  description = "The URL of the Dead Letter Queue"
  value       = aws_sqs_queue.dlq_queue.id
}
