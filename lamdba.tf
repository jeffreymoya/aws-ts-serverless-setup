resource "aws_lambda_layer_version" "common_layer" {
  filename         = "path/to/layer.zip"     # Replace with your Lambda Layer zip file path
  layer_name       = "common-dependencies"
  compatible_runtimes = ["nodejs16.x"]
}

resource "aws_lambda_function" "saas_lambda" {
  filename         = "path/to/lambda.zip"   # Replace with your Lambda zip file path
  function_name    = "saas-function"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  runtime          = "nodejs16.x"
  layers           = [aws_lambda_layer_version.common_layer.arn]
  environment {
    variables = {
      REDIS_URL      = "redis://redis:6379"
      DATABASE_URL   = "postgresql://admin:admin@postgres:5432/saas_db"
    }
  }
  vpc_config {
    subnet_ids         = [aws_subnet.private_subnet.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
  depends_on = [aws_iam_role_policy_attachment.lambda_policy_attach]
}

resource "aws_lambda_function" "lambda_authorizer" {
  filename         = "path/to/authorizer.zip"  # Replace with your Lambda zip file path
  function_name    = "saas-authorizer"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.authorizer"
  runtime          = "nodejs16.x"
  environment {
    variables = {
      COGNITO_USER_POOL_ID = aws_cognito_user_pool.user_pool.id
    }
  }
  vpc_config {
    subnet_ids         = [aws_subnet.private_subnet.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
  depends_on = [aws_iam_role_policy_attachment.lambda_policy_attach]
}


