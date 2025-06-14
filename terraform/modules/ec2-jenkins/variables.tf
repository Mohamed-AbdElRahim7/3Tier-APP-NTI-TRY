variable "project_name" {
  type        = string
  description = "Project name for tagging"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for Jenkins EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type for Jenkins EC2"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to launch the EC2 instance"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for EC2"
}

variable "key_name" {
  type        = string
  description = "SSH key name to access the EC2"
}