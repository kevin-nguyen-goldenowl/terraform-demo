variable "rds_sg_id" {
  type = string
}

variable "db_engine" {
  type = string
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_engine_version" {
  type = string
}

variable "db_allocated_storage" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "app_name" {
  type = string
}

variable "app_env" {
  type = string
}
