output "rds_hostname" {
  value = aws_db_instance.app_rds.address
}
output "rds_db_name" {
  value = aws_db_instance.app_rds.db_name
}
