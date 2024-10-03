# Step Functions State Machine Role
resource "aws_iam_role" "step_functions_role" {
  name = var.step_functions_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "states.${data.aws_region.current.name}.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

# IAM Policy for Step Functions to invoke Lambda and access logs
resource "aws_iam_policy" "step_functions_policy" {
  name = "${var.step_functions_role_name}-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "lambda:InvokeFunction"
        ],
        Resource = var.lambda_function_arns
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })

  tags = var.tags
}

# Attach the policy to the Step Functions role
resource "aws_iam_role_policy_attachment" "step_functions_policy_attachment" {
  role       = aws_iam_role.step_functions_role.name
  policy_arn = aws_iam_policy.step_functions_policy.arn
}

# Define the Step Functions State Machine
resource "aws_sfn_state_machine" "saas_state_machine" {
  name     = var.state_machine_name
  role_arn = aws_iam_role.step_functions_role.arn

  definition = templatefile("${path.module}/step_function_definition.json", {
    create_user_lambda_arn = var.create_user_lambda_arn,
    validate_user_lambda_arn = var.validate_user_lambda_arn,
    notify_user_lambda_arn = var.notify_user_lambda_arn
  })

  tags = var.tags
}
# Call Lambda Modules for Different Functions
module "lambda_create_user" {
  source                  = "../../modules/lambda"
  filename                = "../../lambda/create_user.zip"
  function_name           = "dev-create-user-function"
  lambda_role_arn         = module.iam.lambda_role_arn
  handler                 = "index.createUser"
  memory_size             = var.lambda_memory_size
  timeout                 = var.lambda_timeout
  subnet_ids              = module.vpc.private_subnet_ids
  security_group_ids      = [module.vpc.security_group_id]
  environment_variables   = {
    DATABASE_URL = var.database_url
  }
}

module "lambda_validate_user" {
  source                  = "../../modules/lambda"
  filename                = "../../lambda/validate_user.zip"
  function_name           = "dev-validate-user-function"
  lambda_role_arn         = module.iam.lambda_role_arn
  handler                 = "index.validateUser"
  memory_size             = var.lambda_memory_size
  timeout                 = var.lambda_timeout
  subnet_ids              = module.vpc.private_subnet_ids
  security_group_ids      = [module.vpc.security_group_id]
  environment_variables = {}
}

# Call Step Functions Module
module "step_functions" {
  source                    = "../../modules/step-functions"
  step_functions_role_name  = "dev-step-functions-role"
  state_machine_name        = "dev-user-workflow-state-machine"
  lambda_function_arns      = [
    module.lambda_create_user.lambda_arn,
    module.lambda_validate_user.lambda_arn
  ]
  create_user_lambda_arn    = module.lambda_create_user.lambda_arn
  validate_user_lambda_arn  = module.lambda_validate_user.lambda_arn
  notify_user_lambda_arn    = module.lambda_notify_user.lambda_arn
}

