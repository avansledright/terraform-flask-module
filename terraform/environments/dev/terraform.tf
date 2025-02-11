data "terraform_remote_state" "remote" {
  count   = var.remote_state ? 1 : 0
  backend = "s3"
  
  config = {
    bucket         = var.terraform_state_bucket
    key            = "terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = var.terraform_state_table
    encrypt        = true
  }
}