variable "app_name" {
  type        = string
  description = "Application name"
}

variable "app_env" {
  type        = string
  description = "Application environment"
}

variable "sshkey_dir" {
  type        = string
  description = "The location on machine where the key is stored"
}

variable "app_security_group_id" {
  type = string
}

variable "elb_security_group_id" {
  type = string
}

variable "instances_type" {
  type        = string
  description = "Instance for beanstalk run type"
  default     = "t3.micro"
}

variable "instance_port" {
  type        = string
  description = "The exposed port of instances"
}

// Roles for running
variable "service_role" {
  type        = string
  description = "Service role for running"
}

variable "ec2_role" {
  type        = string
  description = "EC2 instance profile"
}

// Auto scaling settings
variable "min_size" {
  type        = number
  description = "Min instance allowed"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Min instance allowed"
  default     = 2
}

// Net work and load balancer
variable "vpc_id" {
  type = string
}

// Environment variables
variable "env_vars" {
  type = map(string)
}
