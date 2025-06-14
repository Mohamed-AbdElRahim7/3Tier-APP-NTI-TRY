locals {
  # تقدر تضيف لو محتاج أي قيمة لاحقًا هنا
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "nti-rds-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  username               = var.db_username
  password               = var.db_password
  allocated_storage      = var.db_allocated_storage
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  vpc_security_group_ids = [var.db_sg_id]

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false
  storage_encrypted      = true

  tags = {
    Name = "nti-rds"
  }
}
