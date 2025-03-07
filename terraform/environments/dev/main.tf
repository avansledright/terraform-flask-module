provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # Uncomment below for remote state and update the tfvars file
  # backend "s3" {
  #   bucket = var.terraform_state_bucket  
  #   key    = "${var.app_name}/terraform.tfstate"
  #   dynamodb_table = var.terraform_state_table
  #   region = "us-east-1" 
  # }
}

module "ecr" {
  source = "../../modules/ecr"

  app_name        = var.app_name
  environment     = var.environment
  repository_name = var.repository_name
}

module "networking" {
  source = "../../modules/networking"

  app_name           = var.app_name
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
}

module "alb" {
  source = "../../modules/alb"

  app_name          = var.app_name
  environment       = var.environment
  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  app_port          = var.app_port
}

module "ecs" {
  source = "../../modules/ecs"

  app_name              = var.app_name
  environment           = var.environment
  vpc_id                = module.networking.vpc_id
  public_subnet_ids     = module.networking.public_subnet_ids
  alb_security_group_id = module.alb.alb_security_group_id
  target_group_arn      = module.alb.target_group_arn
  app_image             = "${module.ecr.repository_url}:latest"
  app_port              = var.app_port
  app_count             = var.app_count
  ecr_repository        = module.ecr.repository_url
  # Optional
  cpu_value    = 256
  memory_value = 512
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "ecr_registry_id" {
  value = module.ecr.registry_id
}