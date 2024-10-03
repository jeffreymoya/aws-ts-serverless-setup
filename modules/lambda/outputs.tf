output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.saas_lambda.function_name
}

output "lambda_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.saas_lambda.arn
}
