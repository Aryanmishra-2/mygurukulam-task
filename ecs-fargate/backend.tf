terraform {
  backend "s3" {
    bucket  = "aryan-terraform-state-1"
    key     = "ecs-fargate/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}

