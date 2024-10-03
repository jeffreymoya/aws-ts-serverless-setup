# Output the ARN of the Step Functions state machine
output "step_functions_arn" {
  description = "The ARN of the Step Functions state machine"
  value       = aws_sfn_state_machine.saas_state_machine.arn
}

# Output the IAM role ARN used by the Step Functions state machine
output "step_functions_role_arn" {
  description = "The ARN of the IAM role used by Step Functions"
  value       = aws_iam_role.step_functions_role.arn
}
