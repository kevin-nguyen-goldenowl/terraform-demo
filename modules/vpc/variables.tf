variable "app_name" {
  type        = string
  description = "Application name"
}

variable "app_env" {
  type        = string
  description = "Application environment"
}

variable "container_port" {
  type        = number
  description = "Container port (if you have NGINX and use it in compose, please set this to 80)"
}
