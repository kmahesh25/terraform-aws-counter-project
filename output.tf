output "vpc_id" {
  description = "Default VPC ID"
  value       = local.vpc_id
}

output "vpc_cidr" {
  description = "CIDR in Default VPC"
  value       = local.vpc_cidr
}

output "public_subnet_ids" {
  description = "Public Subnets in Default VPC"
  value       = local.public_subnet_ids
}

output "public_subnets_cidr" {
  description = "CIDR in Default VPC Public Subnets"
  value       = local.public_subnets_cidr
}

output "availability_zones" {
  description = "AZ in Default VPC Subnets"
  value       = local.availability_zones
}

output "availability_zone_ids" {
  description = "AZ IDS in Default VPC Subnets"
  value       = local.availability_zone_ids
}

output "private_subnets_cidr" {
  description = "private subnet cidr in default VPC"
  value       = var.private_subnets_cidr
}

output "private_subnet_ids" {
  description = "private subnets id in default VPC"
  value       = local.private_subnet_ids
}

output "amzn_ami_id" {
  description = "Amazon Linux recent AMI ID"
  value       = local.amzn_ami_id
}

output "alb_sgid" {
  description = "ALB Security Group ID"
  value       = local.alb_sg
}

output "asg_sgid" {
  description = "Autoscaling Group Security Group ID"
  value       = local.asg_sg
}

output "asg_iam_profile_name" {
  description = "Autoscaling Group Instances IAM Profile Name"
  value       = local.iam_profile_name
}

output "s3_bucket_arn" {
  description = "Project S3 Bucket arn"
  value       = local.s3_bucket_arn
}

output "asg_id" {
  description = "Auto Scaling Group ID"
  value       = local.asg_id
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS Name"
  value       = local.alb_dns_name
}
