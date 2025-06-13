output "s3_bucket_name" {
  value       = aws_s3_bucket.elb_logs.id
  description = "Name of the S3 bucket for ELB logs"
}