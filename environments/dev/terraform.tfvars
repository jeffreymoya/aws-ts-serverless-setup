# terraform.tfvars for dev environment

aws_region = "us-east-1"
vpc_cidr_block = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24"]
private_subnets = ["10.0.2.0/24"]
lambda_memory_size = 128
lambda_timeout = 30
database_url = "postgresql://admin:admin@postgres:5432/saas_db"
redis_url = "redis://redis:6379"