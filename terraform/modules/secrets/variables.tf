variable "project_name" {
  type        = string
  description = "Project name for tagging"
}

variable "db_username" {
  type        = string
  description = "RDS username"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "RDS password"
}