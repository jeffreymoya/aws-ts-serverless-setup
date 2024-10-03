# Output the REST API ID
output "rest_api_id" {
  description = "The ID of the REST API"
  value       = aws_api_gateway_rest_api.saas_api.id
}

# Output the resource ID
output "resource_id" {
  description = "The ID of the resource within the API"
  value       = aws_api_gateway_resource.resource.id
}

# Output the API Gateway Invoke URL
output "invoke_url" {
  description = "The invoke URL of the deployed API"
  value       = aws_api_gateway_deployment.api_deployment.invoke_url
}
