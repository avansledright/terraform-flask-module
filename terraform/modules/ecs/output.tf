output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "service_name" {
  value = aws_ecs_service.main.name
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.app.arn
}

output "ecs_security_group_id" {
  value = aws_security_group.ecs_tasks.id
}