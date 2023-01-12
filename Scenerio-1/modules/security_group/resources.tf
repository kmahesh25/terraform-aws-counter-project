# Variables
variable "vpc_id" {}
variable "sg_name" {}

variable "cidr_ingress_rules" {
  type    = list(list(string))
  default = []
}

variable "sg_ingress_rules" {
  type    = list(list(string))
  default = []
}


# Resources
resource "aws_security_group" "sg" {
  name   = var.sg_name
  vpc_id = var.vpc_id
  tags = {
    Name = var.sg_name
  }
}

resource "aws_security_group_rule" "egress_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "cidr_rule" {
  count             = length(var.cidr_ingress_rules)
  type              = "ingress"
  from_port         = var.cidr_ingress_rules[count.index][0]
  to_port           = var.cidr_ingress_rules[count.index][1]
  protocol          = var.cidr_ingress_rules[count.index][2]
  cidr_blocks       = [var.cidr_ingress_rules[count.index][3]]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "sg_rule" {
  count                    = length(var.sg_ingress_rules)
  type                     = "ingress"
  from_port                = var.sg_ingress_rules[count.index][0]
  to_port                  = var.sg_ingress_rules[count.index][1]
  protocol                 = var.sg_ingress_rules[count.index][2]
  source_security_group_id = var.sg_ingress_rules[count.index][3]
  security_group_id        = aws_security_group.sg.id
}


# Outputs
output "sg_id" {
  description = "Security Group ID"
  value       = aws_security_group.sg.id
}

output "sg_name" {
  description = "Security Group Name"
  value       = var.sg_name
}
