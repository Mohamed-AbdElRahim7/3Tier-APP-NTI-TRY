resource "aws_backup_vault" "jenkins_vault" {
  name = "${var.project_name}-backup-vault"

  tags = {
    Name = "${var.project_name}-backup-vault"
  }
}

resource "aws_backup_plan" "jenkins_plan" {
  name = "${var.project_name}-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.jenkins_vault.name
    schedule          = "cron(0 5 * * ? *)"  # Every day at 5 AM UTC
    lifecycle {
      delete_after = 14  # keep backup for 14 days
    }
  }

  tags = {
    Name = "${var.project_name}-backup-plan"
  }
}

resource "aws_backup_selection" "jenkins_selection" {
  name         = "jenkins-selection"
  iam_role_arn = var.backup_role_arn
  plan_id      = aws_backup_plan.jenkins_plan.id

  resources = [var.jenkins_instance_arn]
}