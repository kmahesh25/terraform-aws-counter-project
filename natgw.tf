module "natgw_1" {
  source         = "./modules/nat_gateway"
  subnet_id      = local.public_subnet_ids[0]
  route_table_id = local.private_route_table_id
}
