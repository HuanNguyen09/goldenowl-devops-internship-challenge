terraform {
  required_version = ">= 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "networking" {
  source             = "./modules/networking"
  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
  public_subnet_ips  = var.public_subnet_ips
  private_subnet_ips = var.private_subnet_ips
  vpc_name           = var.vpc_name
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

module "alb" {
  source = "./modules/alb"
  public_subnet_ips = module.networking.public_subnet_ids
  public_sg_id = module.security.public_sg_id
  vpc_id = module.networking.vpc_id
}


# module "ecs" {
#   source = "./modules/ecs"
#   vpc_id = module.networking.vpc_id
#   ecr_name = var.ecr_name
#   ecs_name = var.ecs_name
#   alb_arn = module.alb.alb_arn
#   image_defaut = var.image_defaut
#   lb_target_group_arn = module.alb.lb_target_group_arn
#   alb_listener = module.alb.alb_listener
#   alb_dns_name = module.alb.alb_dns_name
# }
