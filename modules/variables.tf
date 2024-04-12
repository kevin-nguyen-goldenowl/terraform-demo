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

# Instance setting
variable "min_size" {
  type        = number
  description = "Min size of scaling"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Max size of scaling"
  default     = 2
}

# IAM setting
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
  default     = "postgres"
}

variable "db_instance_class" {
  type        = string
  description = "Database type"
  default     = "db.t3.micro"
}

variable "db_engine_version" {
  type        = string
  description = "Database version"
  default     = "14.5"
}

variable "db_allocated_storage" {
  type        = string
  description = "Database storage"
  default     = "10"
}

variable "db_username" {
  type        = string
  description = "Database username"
  default     = "postgres"
}

variable "db_password" {
  type        = string
  description = "Database username"
  default     = "pass"
}
