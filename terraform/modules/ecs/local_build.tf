locals {
  app_path = "${path.root}/../../app"
  dockerfile_path = "${path.root}/../../Dockerfile"
  # Get all files in the app directory
  app_files = fileset(local.app_path, "**/*")
  
  # Calculate hashes for all app files
  app_hashes = [for file in local.app_files : filemd5("${local.app_path}/${file}")]
  
  # Add Dockerfile hash if it exists
  dockerfile_hash = fileexists(local.dockerfile_path) ? filemd5(local.dockerfile_path) : ""
  
  # Combine all hashes and create a single hash
  combined_hash = md5(join("", concat(local.app_hashes, [local.dockerfile_hash])))
}

data "aws_region" "current" {}


resource "null_resource" "docker_build" {
  triggers = {
    app_hash = local.combined_hash
  }

  provisioner "local-exec" {
    command = <<-EOT
      # Login to ECR
      aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${var.ecr_repository}
      
      # Build the image
      docker build -t ${var.ecr_repository}:latest ${local.app_path}
      
      # Tag and push the image
      docker push ${var.ecr_repository}:latest
      
      # Remove local image
      docker rmi ${var.ecr_repository}:latest
    EOT
  }
}