variable "sqs_main_queue_name" {
  description = "The name of the main SQS queue"
  type        = string
}

variable "sqs_dlq_name" {
  description = "The name of the Dead Letter Queue"
  type        = string
}
