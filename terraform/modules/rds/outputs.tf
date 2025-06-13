output "rds_endpoint" {
  value       = aws_db_instance.main.endpoint
  description = "RDS endpoint for connecting from backend"
}

output "rds_identifier" {
  value       = aws_db_instance.main.id
  description = "RDS instance identifier"
}