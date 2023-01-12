module "private_subnet_resources" {
  source               = "./modules/private_subnets"
  vpc_id               = local.vpc_id
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = local.availability_zones
}
