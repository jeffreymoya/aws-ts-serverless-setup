variable "glue_job_name" {
  description = "The name of the Glue job"
  type        = string
}

variable "glue_database_name" {
  description = "The name of the Glue catalog database"
  type        = string
}

variable "glue_job_role_name" {
  description = "The name of the IAM role for Glue job"
  type        = string
}

variable "glue_job_policy_name" {
  description = "The name of the IAM policy for Glue job"
  type        = string
}

variable "script_location" {
  description = "The S3 location of the Glue job script"
  type        = string
}

variable "input_s3_bucket_arn" {
  description = "The ARN of the S3 bucket for input data"
  type        = string
}

variable "output_s3_bucket_arn" {
  description = "The ARN of the S3 bucket for output data"
  type        = string
}

variable "temp_dir" {
  description = "The temporary directory for Glue job"
  type        = string
  default     = "s3://path/to/temp/"
}

variable "glue_version" {
  description = "The Glue version for the job"
  type        = string
  default     = "2.0"
}

variable "worker_type" {
  description = "The worker type for Glue job"
  type        = string
  default     = "G.1X"
}

variable "number_of_workers" {
  description = "The number of workers for the Glue job"
  type        = number
  default     = 2
}

variable "max_retries" {
  description = "The maximum number of retries for the Glue job"
  type        = number
  default     = 1
}

variable "timeout" {
  description = "The job timeout in minutes"
  type        = number
  default     = 60
}

variable "tags" {
  description = "Tags to apply to Glue resources"
  type        = map(string)
  default     = {}
}
