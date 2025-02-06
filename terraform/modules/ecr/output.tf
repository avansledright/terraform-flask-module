output "repository_url" {
  description = "The URL of the repository"
  value       = aws_ecr_repository.main.repository_url
}

output "repository_arn" {
  description = "The ARN of the repository"
  value       = aws_ecr_repository.main.arn
}

output "registry_id" {
  description = "The registry ID where the repository was created"
  value       = aws_ecr_repository.main.registry_id
}

output "ecr_access_policy_arn" {
  description = "The ARN of the ECR access policy"
  value       = aws_iam_policy.ecr_access.arn
}