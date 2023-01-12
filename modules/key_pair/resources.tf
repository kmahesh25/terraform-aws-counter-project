# Variables
variable "key_name" {}
variable "public_key" {}


# Resources
resource "aws_key_pair" "key_pair" {
  key_name_prefix = var.key_name
  public_key      = var.public_key
}


# Outputs
output "key_pair_name" {
  value = aws_key_pair.key_pair.key_name
}
