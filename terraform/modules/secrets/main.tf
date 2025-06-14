resource "aws_secretsmanager_secret" "rds" {
  name = "${var.project_name}-rds-credentials-14-5-2025"

  tags = {
    Name    = "${var.project_name}-rds-secret"
    Project = var.project_name
  }
}

resource "aws_secretsmanager_secret_version" "rds" {
  secret_id     = aws_secretsmanager_secret.rds.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })
}
