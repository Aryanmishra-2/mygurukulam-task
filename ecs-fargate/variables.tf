variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "container_image" {
  type        = string
  description = "Docker image for ECS task"
  default     = "nginx:latest"
}

variable "container_port" {
  type    = number
  default = 8080
}

variable "desired_count" {
  type    = number
  default = 2
}

variable "task_cpu" {
  type    = string
  default = "256"
}

variable "task_memory" {
  type    = string
  default = "512"
}

