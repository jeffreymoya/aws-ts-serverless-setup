output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}
# Output the security group ID for Lambda functions
output "lambda_sg_id" {
  description = "The ID of the security group for Lambda functions"
  value       = aws_security_group.lambda_sg.id
}