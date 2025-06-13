output "cluster_name" {
  value       = module.eks.cluster_name
  description = "The name of the EKS cluster"
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "The endpoint for the EKS cluster"
}

output "cluster_security_group_id" {
  value       = module.eks.cluster_security_group_id
  description = "EKS cluster security group ID"
}

output "node_group_role_arn" {
  value       = module.eks.eks_managed_node_groups.default.iam_role_arn
  description = "IAM role ARN for node group"
}