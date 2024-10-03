variable "aws_region" {
  description = "AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# Lambda Configuration
variable "lambda_memory_size" {
  description = "Memory size for the Lambda functions"
  type        = number
  default     = 128
}

variable "lambda_timeout" {
  description = "Timeout for the Lambda functions"
  type        = number
  default     = 30
}

variable "database_url" {
  description = "Database URL for the Lambda functions"
  type        = string
  default     = "postgresql://admin:admin@postgres:5432/saas_db"
}

variable "db_username" {
  description = "The database username for the dev environment"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The database password for the dev environment"
  type        = string
  default     = "admin"
}

variable "redis_url" {
  description = "The URL of the Redis instance"
  type        = string
  default     = "redis://redis:6379"  # Default URL for the Redis instance running in Docker
}
