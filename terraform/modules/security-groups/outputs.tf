output "rds_sg_id" {
  value       = aws_security_group.rds_sg.id
  description = "RDS security group ID"
}

output "jenkins_sg_id" {
  value       = aws_security_group.jenkins_sg.id
  description = "Jenkins EC2 security group ID"
}