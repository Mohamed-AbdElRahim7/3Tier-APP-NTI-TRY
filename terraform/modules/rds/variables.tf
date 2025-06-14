variable "project_name" {
  type        = string
  description = "Project name for tagging"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for RDS subnet group"
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_instance_class" {
  type        = string
  description = "Instance class for RDS"
}

variable "db_allocated_storage" {
  type        = number
  description = "Allocated storage for RDS"
}

variable "db_sg_id" {
  type        = string
  description = "Security Group ID for RDS instance"
}

variable "db_secret_arn" {
  type        = string
  description = "ARN of the secret storing RDS credentials"
}

  description = "Database master username"
  type        = string
}
