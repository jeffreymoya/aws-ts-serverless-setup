# Lambda Permission to Allow SQS to Invoke Lambda
resource "aws_lambda_permission" "allow_sqs_invoke" {
  statement_id  = "AllowSQSInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.saas_lambda.function_name
  principal     = "sqs.amazonaws.com"
  source_arn    = aws_sqs_queue.main_queue.arn
}

# SQS Event Source Mapping to Lambda
resource "aws_lambda_event_source_mapping" "sqs_event" {
  event_source_arn = aws_sqs_queue.main_queue.arn
  function_name    = aws_lambda_function.saas_lambda.arn
  batch_size       = 10
  enabled          = true
}
