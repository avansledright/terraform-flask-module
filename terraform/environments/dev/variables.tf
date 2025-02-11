variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "hello-web"
}

variable "app_port" {
  description = "Port on which the application runs"
  type        = number
  default     = 5000
}

variable "app_count" {
  description = "Number of docker containers to run"
  type        = number
  default     = 2
}

variable "remote_state" {
  description = "Use remote state"
  type = bool
  default = false
}

variable "terraform_state_bucket" {
  description = "Bucket to store the statefile in"
  type = string
}

variable "terraform_state_table" {
  description = "Bucket to store the statefile in"
  type = string
}