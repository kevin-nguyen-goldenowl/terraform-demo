variable "app_name" {
  type        = string
  description = "Application name"
}

variable "app_env" {
  type        = string
  description = "Application environment"
}

variable "instance_port" {
  type        = number
  description = "Exposed port of container"
}

variable "sshkey_dir" {
  type        = string
  description = "Directory where the key is stored in your computer"
}

variable "min_size" {
  type        = number
  description = "Min size of scaling"
}

variable "max_size" {
  type        = number
  description = "Max size of scaling"
}

variable "service_role" {
  type        = string
  description = "Service role for running"
}

variable "ec2_role" {
  type        = string
  description = "EC2 role for running"
}

// Database setting
variable "db_engine" {
  type        = string
  description = "Database engine"
}

variable "db_instance_class" {
  type        = string
  description = "Database type"
}

variable "db_engine_version" {
  type        = string
  description = "Database version"
}

variable "db_allocated_storage" {
  type        = string
  description = "Database Storage"
}

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_password" {
  type        = string
  description = "Database username"
}
