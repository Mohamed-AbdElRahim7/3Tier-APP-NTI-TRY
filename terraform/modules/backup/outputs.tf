output "backup_vault_name" {
  value       = aws_backup_vault.jenkins_vault.name
  description = "Name of the backup vault"
}

output "backup_plan_id" {
  value       = aws_backup_plan.jenkins_plan.id
  description = "ID of the backup plan"
}