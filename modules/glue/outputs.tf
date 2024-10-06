output "glue_job_arn" {
  description = "The ARN of the Glue job"
  value       = aws_glue_job.job.arn
}

output "glue_database_arn" {
  description = "The ARN of the Glue catalog database"
  value       = aws_glue_catalog_database.main.arn
}
