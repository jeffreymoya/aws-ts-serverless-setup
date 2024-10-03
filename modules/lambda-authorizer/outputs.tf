output "authorizer_id" {
  description = "The ID of the API Gateway authorizer"
  value       = aws_api_gateway_authorizer.lambda_authorizer.id
}
