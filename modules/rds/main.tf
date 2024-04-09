resource "aws_db_instance" "app_rds" {
  engine                 = var.db_engine
  db_name                = "ideas_api_${var.app_env}"
  identifier             = "${var.app_name}-${var.app_env}-db"
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  publicly_accessible    = false
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [var.rds_sg_id]
  skip_final_snapshot    = true
}
