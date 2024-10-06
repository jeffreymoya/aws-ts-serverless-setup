# EventBridge Rule to Trigger AWS Glue Job
resource "aws_cloudwatch_event_rule" "glue_job_trigger_rule" {
  name        = var.glue_trigger_rule_name
  description = "EventBridge rule to trigger AWS Glue job"
  event_pattern = jsonencode({
    "source"     = ["aws.glue"],
    "detail-type" = ["Glue Job State Change"],
    "detail" = {
      "state" = ["SUCCEEDED", "FAILED"]
    }
  })
}

# EventBridge Rule to Trigger Lambda Function
resource "aws_cloudwatch_event_rule" "lambda_trigger_rule" {
  name        = var.lambda_trigger_rule_name
  description = "EventBridge rule to trigger Lambda function on custom events"
  event_pattern = jsonencode({
    "source"     = ["custom.my_application"],
    "detail-type" = ["Lambda Trigger"],
    "detail" = {
      "action" = ["start_process"]
    }
  })
}

# EventBridge Target to Trigger AWS Glue Job
resource "aws_cloudwatch_event_target" "glue_job_target" {
  rule = aws_cloudwatch_event_rule.glue_job_trigger_rule.name
  arn  = var.glue_job_arn  # Reference the ARN of the Glue job to trigger
}

# EventBridge Target to Trigger Lambda Function
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.lambda_trigger_rule.name
  arn       = var.lambda_function_arn
  input     = jsonencode({ "message": "Start process triggered by EventBridge" })
}

# Permission for EventBridge to invoke Lambda function
resource "aws_lambda_permission" "allow_eventbridge_to_lambda" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_trigger_rule.arn
}

# EventBridge Rule to Listen to S3 Events (optional)
resource "aws_cloudwatch_event_rule" "s3_event_rule" {
  name        = var.s3_event_rule_name
  description = "EventBridge rule to listen to S3 events"
  event_pattern = jsonencode({
    "source"     = ["aws.s3"],
    "detail-type" = ["Object Created"]
  })
}

# EventBridge Target for S3 Event Rule (Optional)
resource "aws_cloudwatch_event_target" "s3_lambda_target" {
  rule = aws_cloudwatch_event_rule.s3_event_rule.name
  arn  = var.lambda_function_arn
}
