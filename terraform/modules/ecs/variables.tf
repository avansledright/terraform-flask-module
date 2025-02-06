variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "ALB security group ID"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "app_port" {
  description = "Port on which the application runs"
  type        = number
  default     = 5000
}

variable "app_image" {
  description = "Docker image for the application"
  type        = string
}

variable "app_count" {
  description = "Number of docker containers to run"
  type        = number
  default     = 2
}

variable "ecr_repository" {
  description = "URL of the ECR repository"
  type        = string
}