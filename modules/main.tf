module "vpc" {
  source         = "./vpc"
  app_name       = var.app_name
  app_env        = var.app_env
  container_port = var.instance_port
}

module "ecr" {
  source   = "./ecr"
  app_name = var.app_name
  app_env  = var.app_env
}

module "rds" {
  source               = "./rds"
  app_name             = var.app_name
  app_env              = var.app_env
  rds_sg_id            = module.vpc.rds_sg.id
  db_allocated_storage = var.db_allocated_storage
  db_engine            = var.db_engine
  db_engine_version    = var.db_engine_version
  db_instance_class    = var.db_instance_class
  db_password          = var.db_password
  db_username          = var.db_username
}

module "beanstalk" {
  source                = "./beanstalk"
  app_name              = var.app_name
  app_env               = var.app_env
  app_security_group_id = module.vpc.beanstalk_sg.id
  elb_security_group_id = module.vpc.elb_sg.id
  instance_port         = var.instance_port
  sshkey_dir            = var.sshkey_dir
  vpc_id                = module.vpc.vpc.id
  ec2_role              = var.ec2_role
  service_role          = var.service_role
  env_vars = {
    "RAILS_ENV"    = var.app_env
    "RDS_USERNAME" = var.db_username
    "RDS_PASSWORD" = var.db_password
    "RDS_DB_NAME"  = module.rds.rds_db_name
    "RDS_HOSTNAME" = module.rds.rds_hostname
  }
}
