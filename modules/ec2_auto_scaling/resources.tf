# Variables
variable "project" {}

## Launch Template Variables
variable "ami_id" {}
variable "inst_type" {}
variable "key_name" {}
variable "sg_ids" {}
variable "user_data" {}
variable "iam_profile" {}

## ASG Variables
variable "min_capacity" {}
variable "max_capacity" {}
variable "desired_capacity" {}
variable "subnets" {}
variable "tg_arn" {}
variable "natgw_route" {}


# Resources
resource "aws_launch_template" "launch_template" {
  image_id               = var.ami_id
  instance_type          = var.inst_type
  key_name               = var.key_name
  update_default_version = true
  vpc_security_group_ids = var.sg_ids
  user_data              = var.user_data
  name                   = format("project-%s-lt", var.project)
  iam_instance_profile {
    name = var.iam_profile
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = format("project-%s-lt", var.project)
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  name                = format("project-%s-asg", var.project)
  min_size            = var.min_capacity
  desired_capacity    = var.desired_capacity
  max_size            = var.max_capacity
  force_delete        = true
  vpc_zone_identifier = var.subnets
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
  depends_on = [var.natgw_route]
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [load_balancers, target_group_arns]
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = var.tg_arn
}


# Outputs
output "asg_id" {
  value = aws_autoscaling_group.asg.id
}
