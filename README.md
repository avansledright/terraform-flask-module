# Flask Web Application with AWS Infrastructure

This repository contains a Flask web application with automated infrastructure deployment using Terraform on AWS ECS.

## Project Structure

```
project-root/
├── app/                    # Flask application
├── Dockerfile            # Container configuration
├── terraform/             # Infrastructure as Code
│   ├── environments/      # Environment-specific configurations
│   └── modules/          # Reusable Terraform modules

```

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0
- Docker
- Python 3.11+

## Local Development

1. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: .\venv\Scripts\activate
   ```

2. Install dependencies:
   ```bash
   pip install -r app/requirements.txt
   ```

3. Run the application locally:
   ```bash
   python app/main.py
   ```

4. Or use Docker Compose:
   ```bash
   docker-compose up --build
   ```

## Deployment
The deployment uses 100% Terraform to build and deploy your container. 

1. Initialize Terraform:
   ```bash
   cd terraform/environments/dev
   terraform init
   ```

2. Apply the infrastructure:
   ```bash
   terraform apply
   ```

## Infrastructure

- VPC with public subnets across multiple availability zones
- Application Load Balancer (ALB)
- Elastic Container Registry (ECR) with lifecycle policies
- ECS Fargate cluster
- Auto-scaling based on CPU utilization
- Security groups for ALB and ECS tasks
- IAM policies for ECR access

## Clean Up

To destroy the infrastructure:
```bash
cd terraform/environments/dev
terraform destroy
```