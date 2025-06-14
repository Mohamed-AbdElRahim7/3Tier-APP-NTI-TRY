############################################
# root-level outputs.tf
############################################

output "eks_cluster_name" {
  value       = module.eks.cluster_name
  description = "EKS Cluster Name"
}

output "rds_endpoint" {
  value       = module.rds.rds_endpoint
  description = "RDS MySQL Endpoint"
}

output "jenkins_public_ip" {
  value       = module.ec2_jenkins.jenkins_public_ip
  description = "Public IP of Jenkins EC2"
}

output "ecr_frontend_url" {
  value       = module.ecr.frontend_repo_url
  description = "ECR URL for frontend"
}

output "ecr_backend_url" {
  value       = module.ecr.backend_repo_url
  description = "ECR URL for backend"
}

output "s3_bucket_name" {
  value       = module.s3.s3_bucket_name
  description = "S3 Bucket for ELB Logs"
}