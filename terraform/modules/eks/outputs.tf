output "cluster_name" {
  value       = aws_eks_cluster.eks.name
  description = "EKS cluster name"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.eks.endpoint
  description = "EKS cluster endpoint"
}

output "cluster_security_group_id" {
  value       = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
  description = "Security group ID for the EKS cluster"
}

output "node_group_role_arn" {
  value       = aws_eks_node_group.default.node_role_arn
  description = "IAM Role ARN for the Node Group"
}
output "node_security_group_id" {
  value       = aws_eks_node_group.default.resources[0].security_group_ids[0]
  description = "Security group ID for EKS node group"
}
