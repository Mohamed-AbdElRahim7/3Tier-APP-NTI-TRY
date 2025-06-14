
locals {
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  subnet_ids = var.private_subnet_ids

  tags = {
  }
}

resource "aws_db_instance" "main" {
  allocated_storage       = var.db_allocated_storage
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.db_instance_class
  vpc_security_group_ids  = [var.db_sg_id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = false
  storage_encrypted       = true
  private_subnet_ids = module.vpc.private_subnet_ids


  tags = {
  }
}
