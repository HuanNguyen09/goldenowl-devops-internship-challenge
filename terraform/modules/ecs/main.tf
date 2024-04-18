# terraform {
#   required_version = ">= 1.4.0"
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = ">= 5.0.0"
#     }
#   }
# }

# resource "aws_ecr_repository" "dev_ecr_repository" {
#   name = var.ecr_name
# }

# # Tạo ECS Cluster
# resource "aws_ecs_cluster" "dev_cluster" {
#   name = var.ecs_name
# }


# # Tạo ECS Task Definition
# resource "aws_ecs_task_definition" "my_task_definition" {
#   family                   = "nodejs"
#   container_definitions   = jsonencode([{
#     name  = "web"
#     image = var.image_defaut
#     cpu = 256
#     memory = 512
#     portMappings = [
#         {
#           containerPort = 3000
#           hostPort      = 80
#         }
#     ]
#   }])
# }

# # Tạo ECS Service
# resource "aws_ecs_service" "my_service" {
#   name            = "my-service"
#   cluster         = aws_ecs_cluster.dev_cluster.arn
#   task_definition = aws_ecs_task_definition.my_task_definition.arn
#   desired_count   = 2

#   deployment_maximum_percent = 200
#   deployment_minimum_healthy_percent = 100

#   load_balancer {
#     target_group_arn = var.lb_target_group_arn
#     container_name   = "my-container"
#     container_port   = 3000
#   }

#   lifecycle {
#     create_before_destroy = true
#   }

#   depends_on = [var.alb_listener]
# }

# # Tạo Auto Scaling Policy
# resource "aws_appautoscaling_target" "ecs_service" {
#   max_capacity       = 4
#   min_capacity       = 2
#   resource_id        = "service/${aws_ecs_cluster.dev_cluster.name}/${aws_ecs_service.my_service.name}"
#   scalable_dimension = "ecs:service:DesiredCount"
#   service_namespace  = "ecs"
# }

# resource "aws_appautoscaling_policy" "ecs_service_scale_out" {
#   name               = "ecs-service-scale-out"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.ecs_service.resource_id
#   scalable_dimension = aws_appautoscaling_target.ecs_service.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.ecs_service.service_namespace

#   target_tracking_scaling_policy_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ECSServiceAverageCPUUtilization"
#     }
#     scale_out_cooldown = 60
#     target_value       = 70.0
#   }
# }

# # Output DNS name của ALB
# output "alb_dns_name" {
#   value = var.alb_dns_name
# }
