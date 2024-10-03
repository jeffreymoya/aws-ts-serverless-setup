resource "aws_security_group" "lambda_sg" {
  name        = "lambda-security-group"
  description = "Security group for Lambda functions"
  vpc_id      = aws_vpc.saas_vpc.id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Replace with your actual VPC CIDR block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
