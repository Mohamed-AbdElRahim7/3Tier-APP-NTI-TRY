output "backup_role_arn" {
  value       = aws_iam_role.backup_role.arn
  description = "ARN of the AWS Backup IAM role"
}

output "jenkins_role_arn" {
  value       = aws_iam_role.jenkins_role.arn
  description = "ARN of the IAM role for Jenkins EC2"
}

output "jenkins_instance_profile" {
  value       = aws_iam_instance_profile.jenkins_profile.name
  description = "Instance profile name for attaching to EC2"
}