locals {
 app_path = abspath("${path.root}/../../../app/")
 dockerfile_path = "${local.app_path}/Dockerfile"
 app_files = fileset(local.app_path, "**/*")
 app_hashes = [for file in local.app_files : filemd5("${local.app_path}/${file}")]
 dockerfile_hash = fileexists(local.dockerfile_path) ? filemd5(local.dockerfile_path) : ""
 combined_hash = md5(join("", concat(local.app_hashes, [local.dockerfile_hash])))
}

data "aws_region" "current" {}


resource "null_resource" "docker_build" {
  triggers = {
    app_hash = local.combined_hash
  }

  provisioner "local-exec" {
    command = "../../../scripts/docker_build.sh ${data.aws_region.current.name} ${var.ecr_repository} ${local.app_path}"
  }
}

resource "null_resource" "ecs_deploy" {
  triggers = {
    app_hash = local.combined_hash
  }

  depends_on = [null_resource.docker_build]

  provisioner "local-exec" {
    command = "aws ecs update-service --cluster ${var.environment}-cluster --service ${var.app_name}-${var.environment}-service --force-new-deployment --region ${data.aws_region.current.name}"
  }
}