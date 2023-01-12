module "asg_1" {
  source           = "./modules/ec2_auto_scaling"
  ami_id           = local.amzn_ami_id
  inst_type        = var.instance_type
  key_name         = local.key_name
  sg_ids           = [local.asg_sg]
  project          = var.project
  iam_profile      = local.iam_profile_name
  user_data        = filebase64("${path.root}/scripts/ec2_bootstrap.sh")
  min_capacity     = var.asg_min_capacity
  desired_capacity = var.asg_desired_capacity
  max_capacity     = var.asg_max_capacity
  subnets          = local.private_subnet_ids
  tg_arn           = local.http_tg_arn
  natgw_route      = local.natgw_route
}
