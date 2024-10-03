# Define a POST method for creating users
resource "aws_api_gateway_method" "create_user_method" {
  rest_api_id   = aws_api_gateway_rest_api.saas_api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "POST"
  authorization = "CUSTOM"  # Use the Lambda Authorizer
  authorizer_id = aws_api_gateway_authorizer.lambda_authorizer.id
}

# Integrate the Lambda function with API Gateway
resource "aws_api_gateway_integration" "lambda_create_user" {
  rest_api_id             = aws_api_gateway_rest_api.saas_api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.create_user_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.saas_lambda.invoke_arn
}
