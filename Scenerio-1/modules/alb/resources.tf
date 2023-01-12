# Variables
variable "project" {}
variable "vpc_id" {}
variable "sg_ids" {}
variable "subnets" {}


# Resources
resource "aws_lb" "alb" {
  name               = format("%s-alb", var.project)
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.sg_ids
  subnets            = var.subnets
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http_tg.arn
  }
}

resource "aws_lb_target_group" "http_tg" {
  name     = format("%s-http", var.project)
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}


# Outputs
output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_http_tg_arn" {
  value = aws_lb_target_group.http_tg.arn
}
