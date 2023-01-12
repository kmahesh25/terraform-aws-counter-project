locals {
  vpc_id                 = data.aws_vpc.default.id
  vpc_cidr               = data.aws_vpc.default.cidr_block
  pvt_subnet_ids         = sort(tolist(data.aws_subnets.private_subnets.ids))
  public_subnet_ids      = sort(tolist(setsubtract(data.aws_subnets.all_subnets.ids, local.pvt_subnet_ids)))
  public_subnets_config  = tolist([for config in data.aws_subnet.public_subnets : config])
  public_subnets_cidr    = sort(tolist([for config in local.public_subnets_config : config["cidr_block"]]))
  availability_zones     = sort(tolist([for config in local.public_subnets_config : config["availability_zone"]]))
  availability_zone_ids  = sort(tolist([for config in local.public_subnets_config : config["availability_zone_id"]]))
  private_subnet_ids     = module.private_subnet_resources.private_subnet_ids
  amzn_ami_id            = data.aws_ami.amazon_linux.id
  private_route_table_id = module.private_subnet_resources.private_route_table_id
  natgw_route            = module.natgw_1.natgw_route
  alb_sg                 = module.alb_sg.sg_id
  asg_sg                 = module.asg_sg.sg_id
  key_name               = module.key_pair.key_pair_name
  s3_bucket_arn          = data.aws_s3_bucket.s3_bucket.arn
  s3_bucket_id           = data.aws_s3_bucket.s3_bucket.id
  iam_role_arn           = module.iam_role_1.iam_role_arn
  iam_profile_name       = module.iam_role_1.iam_profile_name
  asg_id                 = module.asg_1.asg_id
  http_tg_arn            = module.alb_1.alb_http_tg_arn
  alb_dns_name           = module.alb_1.alb_dns_name

}
