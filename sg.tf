module "alb_sg" {
  source             = "./modules/security_group"
  sg_name            = "alb_sg"
  vpc_id             = local.vpc_id
  cidr_ingress_rules = [concat(var.alb_public_access, ["0.0.0.0/0"]), concat(var.alb_public_icmp, ["0.0.0.0/0"])]
}

module "asg_sg" {
  source           = "./modules/security_group"
  sg_name          = "asg_sg"
  vpc_id           = local.vpc_id
  sg_ingress_rules = [concat(var.asg_alb_access, [local.alb_sg])]
}
