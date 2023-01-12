module "alb_1" {
  source  = "./modules/alb"
  project = var.project
  vpc_id  = local.vpc_id
  sg_ids  = [local.alb_sg]
  subnets = local.public_subnet_ids
}
