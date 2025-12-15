############################################
# VPC MODULE
############################################
module "vpc" {
  source = "./modules/vpc"

  name            = "prod"
  cidr            = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  azs_map = {
    "0" = "${var.region}a"
    "1" = "${var.region}b"
  }
}

############################################
# ALB MODULE
############################################
module "alb" {
  source = "./modules/alb"

  name              = "prod"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnets
  alb_sg_id         = module.vpc.alb_sg_id
  target_port       = var.container_port
}

############################################
# ECS MODULE
############################################
module "ecs" {
  source = "./modules/ecs"

  name            = "prod"
  cluster_name    = "prod-ecs-cluster"
  container_image = var.container_image
  container_port  = var.container_port

  private_subnet_ids = module.vpc.private_subnets
  ecs_tasks_sg_id    = module.vpc.ecs_tasks_sg_id
  target_group_arn   = module.alb.tg_arn

  aws_region    = var.region
  desired_count = var.desired_count
  task_cpu      = var.task_cpu
  task_memory   = var.task_memory
}

