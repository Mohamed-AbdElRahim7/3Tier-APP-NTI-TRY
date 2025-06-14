output "jenkins_instance_id" {
  value       = aws_instance.jenkins.id
  description = "The ID of the Jenkins EC2 instance"
}

output "jenkins_public_ip" {
  value       = aws_instance.jenkins.public_ip
  description = "The public IP of the Jenkins EC2 instance"
}

output "jenkins_private_ip" {
  value       = aws_instance.jenkins.private_ip
  description = "The private IP of the Jenkins EC2 instance"
}