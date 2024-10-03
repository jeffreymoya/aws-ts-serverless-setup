variable "filename" {
  description = "The path to the Lambda function zip file"
  type        = string
}

variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "lambda_role_arn" {
  description = "The ARN of the IAM role for the Lambda function"
  type        = string
}

variable "handler" {
  description = "The handler function in the Lambda function code"
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
  default     = "nodejs16.x"
}

variable "memory_size" {
  description = "Memory size for the Lambda function (in MB)"
  type        = number
}

variable "timeout" {
  description = "Timeout for the Lambda function (in seconds)"
  type        = number
}

variable "subnet_ids" {
  description = "List of VPC subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
}
