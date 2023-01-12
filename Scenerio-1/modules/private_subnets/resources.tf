# Variables
variable "vpc_id" {}

variable "private_subnets_cidr" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}


# Resources
resource "aws_subnet" "private_subnets" {
  vpc_id                  = var.vpc_id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = format("%s-private-subnet", element(var.availability_zones, count.index))
    Type = "private"
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
  tags = {
    Name = "private_route_table"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}


# Outputs
output "private_subnet_ids" {
  description = "private subnets id in default VPC"
  value       = aws_subnet.private_subnets.*.id
}

output "private_route_table_id" {
  description = "private Route Table ID"
  value       = aws_route_table.private_route_table.id
}
