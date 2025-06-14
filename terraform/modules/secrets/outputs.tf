output "secret_arn" {
  value       = aws_secretsmanager_secret.rds.arn
  description = "ARN of the RDS credentials secret"
}

output "secret_name" {
  value       = aws_secretsmanager_secret.rds.name
  description = "Name of the secret"
}
output "secret_name" {
  value = aws_secretsmanager_secret.rds.name
}
