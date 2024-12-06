variable "task_family" {
  description = "Name of the ECS task family"
  type        = string
}

variable "container_definitions" {
  description = "JSON-encoded container definitions"
  type        = list(object({
    name         = string
    image        = string
    cpu          = number
    memory       = number
    essential    = bool
    portMappings = list(object({
      containerPort = number
      hostPort      = number
    }))
  }))
}

variable "execution_role_arn" {
  description = "ARN of the IAM execution role"
  type        = string
}

variable "memory" {
  description = "Memory for the task"
  type        = string
}

variable "cpu" {
  description = "CPU for the task"
  type        = string
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "cluster_id" {
  description = "ID of the ECS cluster"
  type        = string
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
}

variable "subnet_ids" {
  description = "Subnets for ECS tasks"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups for ECS tasks"
  type        = list(string)
}

