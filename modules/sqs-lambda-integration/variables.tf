# SQS Queue Variables
variable "sqs_main_queue_name" {
  description = "The name of the main SQS queue"
  type        = string
}

variable "sqs_dlq_name" {
  description = "The name of the Dead Letter Queue"
  type        = string
}

# Lambda Function Variables
variable "lambda_function_name" {
  description = "The name of the Lambda function to be invoked by SQS"
  type        = string
}

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function to be invoked by SQS"
  type        = string
}

# Event Source Mapping Variables
variable "batch_size" {
  description = "The batch size for processing SQS messages"
  type        = number
  default     = 10
}

variable "enabled" {
  description = "Flag to enable or disable the SQS to Lambda event source mapping"
  type        = bool
  default     = true
}
