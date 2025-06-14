variable "project_name" {
  type        = string
  description = "Name used for tagging and naming AWS resources"
}

variable "region" {
  type        = string
  description = "AWS region to deploy infrastructure"
}

variable "account_id" {
  type        = string
  description = "AWS Account ID (used in ARN construction)"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "eks_nodes_cidr" {
  type        = string
  description = "CIDR block for EKS nodes to allow access to RDS"
}

variable "cluster_name" {
  type        = string
  description = "EKS Cluster name"
}

variable "node_instance_type" {
  type        = string
  description = "Instance type for EKS nodes"
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of EKS worker nodes"
}

variable "max_size" {
  type        = number
  description = "Max number of EKS worker nodes"
}

variable "min_size" {
  type        = number
  description = "Min number of EKS worker nodes"
}

variable "db_name" {
  type        = string
  description = "Database name"
}





variable "db_instance_class" {
  type        = string
  description = "RDS instance class"
}

variable "db_allocated_storage" {
  type        = number
  description = "RDS allocated storage (in GB)"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for Jenkins EC2"
}

variable "jenkins_instance_type" {
  type        = string
  description = "Instance type for Jenkins EC2"
}

variable "key_name" {
  type        = string
  description = "SSH key name for Jenkins EC2"
}

variable "elb_logs_bucket_name" {
  type        = string
  description = "S3 bucket name for ELB access logs"
}


variable "db_username" {
  type        = string
  description = "Username for RDS"
}

variable "db_password" {
  type        = string
  description = "Password for RDS"
}
