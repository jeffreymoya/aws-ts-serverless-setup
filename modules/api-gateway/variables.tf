# API Gateway Variables
variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "api_description" {
  description = "The description of the API Gateway"
  type        = string
  default     = "SaaS Application API Gateway"
}

variable "api_resource_path" {
  description = "The path part of the API resource (e.g., 'users')"
  type        = string
  default     = "users"
}

variable "authorization_type" {
  description = "The authorization type to use for the method (e.g., 'NONE', 'AWS_IAM', 'CUSTOM')"
  type        = string
  default     = "NONE"
}

variable "lambda_authorizer_id" {
  description = "The ID of the Lambda authorizer (if using CUSTOM authorization)"
  type        = string
  default     = null
}

# Lambda Integration Variables
variable "lambda_function_invoke_arn" {
  description = "The ARN of the Lambda function to integrate with API Gateway"
  type        = string
}

variable "stage_name" {
  description = "The name of the API Gateway deployment stage"
  type        = string
  default     = "dev"
}
