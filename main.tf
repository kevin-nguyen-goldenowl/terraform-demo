module "app" {
  source               = "./modules/"
  app_name             = var.app_name
  app_env              = var.app_env
  instance_port        = 80
  ec2_role             = var.ec2_role
  service_role         = var.service_role
  db_allocated_storage = var.db_allocated_storage
  db_engine            = var.db_engine
  db_engine_version    = var.db_engine_version
  db_instance_class    = var.db_instance_class
  db_password          = var.db_password
  db_username          = var.db_username
  key_directory        = var.key_directory
}
