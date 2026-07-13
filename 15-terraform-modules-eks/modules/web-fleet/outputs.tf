output "alb_dns_name" {
  description = "Public DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}

output "asg_name" {
  description = "Name of the autoscaling group"
  value       = aws_autoscaling_group.this.name
}
