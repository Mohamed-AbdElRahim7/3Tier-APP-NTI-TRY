resource "aws_s3_bucket" "elb_logs" {
  bucket = var.bucket_name
  force_destroy = true

  tags = {
    Name = var.bucket_name
    Project = var.project_name
  }
}



resource "aws_s3_bucket_server_side_encryption_configuration" "elb_logs_encryption" {
  bucket = aws_s3_bucket.elb_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}