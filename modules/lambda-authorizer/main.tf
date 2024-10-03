resource "aws_lambda_function" "authorizer" {
  filename         = var.filename
  function_name    = var.function_name
  role             = var.lambda_role_arn
  handler          = var.handler
  runtime          = var.runtime
  memory_size      = var.memory_size
  timeout          = var.timeout

  environment {
    variables = var.environment_variables
  }
}

resource "aws_api_gateway_authorizer" "lambda_authorizer" {
  name                   = var.authorizer_name
  rest_api_id            = var.api_gateway_id
  authorizer_uri         = aws_lambda_function.authorizer.invoke_arn
  authorizer_credentials = var.lambda_role_arn
  authorizer_result_ttl_in_seconds = var.authorizer_result_ttl_in_seconds
  type                   = "TOKEN"
}
