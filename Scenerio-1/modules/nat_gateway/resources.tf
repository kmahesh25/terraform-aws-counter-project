# Variables
variable "subnet_id" {}
variable "route_table_id" {}


# Resources
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = var.subnet_id
  depends_on    = [var.route_table_id]
}

resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_route" "natgw_route" {
  route_table_id         = var.route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
  depends_on             = [var.route_table_id]
}


# Outputs
output "natgw_route" {
  value = aws_route.natgw_route
}
