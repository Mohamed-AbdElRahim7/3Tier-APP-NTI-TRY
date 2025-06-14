variable "project_name" {
  type        = string
  description = "Project name for tagging"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to assign security groups"
}

variable "eks_nodes_cidr" {
  type        = string
  description = "CIDR block for EKS nodes"
}