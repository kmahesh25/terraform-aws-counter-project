variable "project" {
  type    = string
  default = "counter"
}

variable "private_subnets_cidr" {
  type = list(string)
  default = [
    "172.31.48.0/20",
    "172.31.64.0/20",
    "172.31.80.0/20"
  ]
}

variable "alb_public_access" {
  type        = list(string)
  description = "The list input should be [string(from_port), string(to_port), string(protocol)]"
  default     = ["80", "80", "tcp"]
}

variable "alb_public_icmp" {
  type        = list(string)
  description = "The list input should be [string(from_port), string(to_port), string(protocol)]"
  default     = ["-1", "-1", "icmp"]
}

variable "asg_alb_access" {
  type        = list(string)
  description = "The list input should be [string(from_port), string(to_port), string(protocol)]"
  default     = ["80", "80", "tcp"]
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "asg_min_capacity" {
  type    = number
  default = 1
}

variable "asg_max_capacity" {
  type    = number
  default = 6
}

variable "asg_desired_capacity" {
  type    = number
  default = 1
}

variable "s3_bucket_name" {
  type    = string
  default = "ap-southeast-1-demo-counter-s3-bucket"
}

variable "iam_role_name" {
  type    = string
  default = "demo-counter-s3-bucket-read-access"
}
