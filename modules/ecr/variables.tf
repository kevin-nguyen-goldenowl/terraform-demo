variable "app_name" {
  type = string
}

variable "app_env" {
  type = string
}

variable "image_tag_mutability" {
  type    = string
  default = "IMMUTABLE"
}

variable "repository_force_delete" {
  type    = string
  default = true
}

variable "max_image_count" {
  type        = number
  default     = 3
  description = "How many Docker Image versions AWS ECR will store."
}

variable "max_untagged_image_count" {
  type        = number
  default     = 1
  description = "How many Untagged Docker Image versions AWS ECR will store."
}
