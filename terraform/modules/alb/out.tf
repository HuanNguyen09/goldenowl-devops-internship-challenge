output "alb_dns_name" {
  value = aws_lb.my_alb.dns_name
}

output "alb_arn" {
  value = aws_lb.my_alb.arn
}

output "lb_target_group_arn" {
  value = aws_lb_target_group.my_target_group.arn
}

output "alb_listener" {
  value = aws_lb_listener.my_alb_listener
}