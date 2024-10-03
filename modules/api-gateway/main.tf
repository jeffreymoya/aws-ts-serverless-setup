# Define the REST API
resource "aws_api_gateway_rest_api" "saas_api" {
  name        = var.api_name
  description = var.api_description
}

# Define a resource within the REST API (e.g., /users)
resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.saas_api.id
  parent_id   = aws_api_gateway_rest_api.saas_api.root_resource_id
  path_part   = var.api_resource_path
}

# Define a POST method for creating users
resource "aws_api_gateway_method" "create_user_method" {
  rest_api_id   = aws_api_gateway_rest_api.saas_api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "POST"
  authorization = var.authorization_type  # Use the Lambda Authorizer if provided
  authorizer_id = var.lambda_authorizer_id
}

# Integrate the Lambda function with API Gateway
resource "aws_api_gateway_integration" "lambda_create_user" {
  rest_api_id             = aws_api_gateway_rest_api.saas_api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.create_user_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_function_invoke_arn  # Referencing Lambda function ARN passed as a variable
}

# Deploy the API Gateway
resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.saas_api.id
  stage_name  = var.stage_name

  # Automatically redeploy when there are changes in methods or integrations
  lifecycle {
    create_before_destroy = true
  }
}

# Create a stage for the deployment
resource "aws_api_gateway_stage" "api_stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.saas_api.id
  stage_name    = var.stage_name
}
