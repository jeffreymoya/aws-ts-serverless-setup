output "lambda_role_arn" {
  description = "The ARN of the Lambda IAM role"
  value       = aws_iam_role.lambda_role.arn
}

output "lambda_policy_arn" {
  description = "The ARN of the Lambda execution policy"
  value       = aws_iam_policy.lambda_basic_execution_policy.arn
}
