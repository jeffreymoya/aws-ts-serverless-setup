variable "filename" {
  description = "The path to the Lambda function zip file"
  type        = string
}

variable "function_name" {
  description = "The name of the Lambda authorizer function"
  type        = string
}

variable "lambda_role_arn" {
  description = "The ARN of the IAM role for the Lambda authorizer"
  type        = string
}

variable "handler" {
  description = "The handler function in the Lambda function code"
  type        = string
  default     = "index.handler"
}

variable "runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
  default     = "nodejs16.x"
}

variable "memory_size" {
  description = "Memory size for the Lambda function (in MB)"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "Timeout for the Lambda function (in seconds)"
  type        = number
  default     = 30
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "authorizer_name" {
  description = "The name of the Lambda authorizer"
  type        = string
}

variable "api_gateway_id" {
  description = "The ID of the API Gateway"
  type        = string
}

variable "authorizer_result_ttl_in_seconds" {
  description = "TTL for the authorizer results"
  type        = number
  default     = 300
}
