# Main SQS Queue
resource "aws_sqs_queue" "main_queue" {
  name                        = var.sqs_main_queue_name
  delay_seconds               = 0
  visibility_timeout_seconds  = 30
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 0
  max_message_size            = 262144
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq_queue.arn
    maxReceiveCount     = 5
  })
}

# Dead Letter Queue (DLQ)
resource "aws_sqs_queue" "dlq_queue" {
  name                        = var.sqs_dlq_name
  message_retention_seconds   = 1209600
  max_message_size            = 262144
}

# Lambda Permission to Allow SQS to Invoke Lambda
resource "aws_lambda_permission" "allow_sqs_invoke" {
  statement_id  = "AllowSQSInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name   # Referencing Lambda function name passed as a variable
  principal     = "sqs.amazonaws.com"
  source_arn    = aws_sqs_queue.main_queue.arn
}

# SQS Event Source Mapping to Lambda
resource "aws_lambda_event_source_mapping" "sqs_event" {
  event_source_arn = aws_sqs_queue.main_queue.arn
  function_name    = var.lambda_function_arn  # Referencing Lambda function ARN passed as a variable
  batch_size       = var.batch_size
  enabled          = var.enabled
}
