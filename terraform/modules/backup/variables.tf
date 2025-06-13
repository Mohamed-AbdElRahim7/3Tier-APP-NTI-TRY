variable "project_name" {
  type        = string
  description = "Project name for tagging"
}

variable "jenkins_instance_arn" {
  type        = string
  description = "ARN of the Jenkins EC2 instance"
}

variable "backup_role_arn" {
  type        = string
  description = "IAM role ARN for AWS Backup to access EC2"
}