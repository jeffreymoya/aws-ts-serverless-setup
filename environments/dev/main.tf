provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source          = "../../modules/vpc"
  cidr_block      = var.vpc_cidr_block
  vpc_name        = "dev-vpc"
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "lambda" {
  source                  = "../../modules/lambda"
  filename                = "../../lambda/function.zip"
  function_name           = "dev-saas-function"
  lambda_role_arn         = module.iam.lambda_role_arn
  handler                 = "index.handler"
  memory_size             = var.lambda_memory_size
  timeout                 = var.lambda_timeout
  subnet_ids              = module.vpc.private_subnet_ids
  security_group_ids      = [module.vpc.lambda_sg_id]
  environment_variables   = {
    DATABASE_URL = var.database_url
    REDIS_URL    = var.redis_url
  }
}

module "sqs" {
  source             = "../../modules/sqs"
  sqs_main_queue_name = "dev-saas-main-queue"
  sqs_dlq_name       = "dev-saas-dlq"
}

# Call the IAM module to create IAM role and policy for Lambda
module "iam" {
  source = "../../modules/iam"
  lambda_role_name = "dev-saas-lambda-role"
}

# Call the VPC, Lambda, and SQS modules as previously defined
module "vpc" {
  source          = "../../modules/vpc"
  cidr_block      = var.vpc_cidr_block
  vpc_name        = "dev-vpc"
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}


module "sqs" {
  source             = "../../modules/sqs"
  sqs_main_queue_name = "dev-saas-main-queue"
  sqs_dlq_name       = "dev-saas-dlq"
}

module "sqs_lambda_integration" {
  source                 = "../../modules/sqs-lambda-integration"
  sqs_main_queue_name    = "dev-saas-main-queue"
  sqs_dlq_name           = "dev-saas-dlq"
  lambda_function_name   = module.lambda.lambda_function_name  # Reference Lambda function name
  lambda_function_arn    = module.lambda.lambda_arn            # Reference Lambda function ARN
  batch_size             = 10
  enabled                = true
}
# Call API Gateway Module
module "api_gateway" {
  source                     = "../../modules/api-gateway"
  api_name                   = "dev-saas-api"
  api_resource_path          = "users"
  authorization_type         = "CUSTOM"
  lambda_authorizer_id       = module.lambda_authorizer.authorizer_id  # Reference the authorizer ID
  lambda_function_invoke_arn = module.lambda.lambda_arn
  stage_name                 = "dev"
}


# Call the Secrets Manager module
module "secrets" {
  source        = "../../modules/secrets"
  db_secret_name = "dev/db_credentials"
  db_username   = var.db_username
  db_password   = var.db_password
  tags          = {
    Environment = "dev"
    Application = "saas-app"
  }
}

module "lambda_authorizer" {
  source                  = "../../modules/lambda-authorizer"
  filename                = "../../lambda/authorizer_function.zip"
  function_name           = "dev-lambda-authorizer"
  lambda_role_arn         = module.iam.lambda_role_arn
  handler                 = "index.handler"
  runtime                 = "nodejs16.x"
  memory_size             = 128
  timeout                 = 30
  environment_variables   = {}
  authorizer_name         = "dev-api-authorizer"
  api_gateway_id          = module.api_gateway.rest_api_id
  authorizer_result_ttl_in_seconds = 300
}




