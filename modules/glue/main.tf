# Glue Database
resource "aws_glue_catalog_database" "main" {
  name = var.glue_database_name
}

# Glue Job Role
resource "aws_iam_role" "glue_job_role" {
  name = var.glue_job_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

# IAM Policy for Glue Job
resource "aws_iam_policy" "glue_job_policy" {
  name        = var.glue_job_policy_name
  description = "IAM policy for AWS Glue job"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          var.input_s3_bucket_arn,
          var.output_s3_bucket_arn
        ]
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
}

# Attach the IAM policy to Glue Job role
resource "aws_iam_role_policy_attachment" "glue_job_policy_attachment" {
  role       = aws_iam_role.glue_job_role.name
  policy_arn = aws_iam_policy.glue_job_policy.arn
}

# Glue Job
resource "aws_glue_job" "job" {
  name        = var.glue_job_name
  role_arn    = aws_iam_role.glue_job_role.arn
  command {
    name            = "glueetl"
    script_location = var.script_location  # S3 path to the Glue job script
  }
  default_arguments = {
    "--TempDir" = var.temp_dir
  }
  max_retries = var.max_retries
  glue_version = var.glue_version
  timeout      = var.timeout
  number_of_workers = var.number_of_workers
  worker_type       = var.worker_type
}
