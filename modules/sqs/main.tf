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

resource "aws_sqs_queue" "dlq_queue" {
  name                        = var.sqs_dlq_name
  message_retention_seconds   = 1209600
  max_message_size            = 262144
}
