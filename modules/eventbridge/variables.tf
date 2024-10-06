variable "glue_trigger_rule_name" {
  description = "The name of the EventBridge rule to trigger AWS Glue jobs"
  type        = string
}

variable "lambda_trigger_rule_name" {
  description = "The name of the EventBridge rule to trigger Lambda function"
  type        = string
}

variable "s3_event_rule_name" {
  description = "The name of the EventBridge rule to listen to S3 events"
  type        = string
  default     = "s3-object-created-event-rule"
}

variable "glue_job_arn" {
  description = "The ARN of the Glue job to be triggered by EventBridge"
  type        = string
}

variable "lambda_function_name" {
  description = "The name of the Lambda function to be triggered by EventBridge"
  type        = string
}

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function to be triggered by EventBridge"
  type        = string
}
