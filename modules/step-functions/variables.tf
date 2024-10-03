variable "step_functions_role_name" {
  description = "Name of the IAM role for Step Functions"
  type        = string
}

variable "state_machine_name" {
  description = "Name of the Step Functions state machine"
  type        = string
}

variable "lambda_function_arns" {
  description = "List of Lambda function ARNs that Step Functions can invoke"
  type        = list(string)
}

variable "create_user_lambda_arn" {
  description = "ARN of the Lambda function for creating users"
  type        = string
}

variable "validate_user_lambda_arn" {
  description = "ARN of the Lambda function for validating users"
  type        = string
}

variable "notify_user_lambda_arn" {
  description = "ARN of the Lambda function for notifying users"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
