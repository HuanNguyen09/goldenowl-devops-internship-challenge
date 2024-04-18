vpc_name           = "Dev_VPC"
availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]
cidr_block         = "10.0.0.0/16"
public_subnet_ips  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_ips = ["10.0.3.0/24", "10.0.4.0/24"]
# image_defaut= "370267611220.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-app:1.0.8743138646"
# ecr_name = "nodejs-ecr"
# ecs_name = "dev-cluster"