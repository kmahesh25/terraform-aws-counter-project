# Variables
variable "role_name" {}
variable "s3_bucket_arn" {}


# Resources
resource "aws_iam_instance_profile" "iam_profile" {
  name = var.role_name
  role = aws_iam_role.iam_role.name
}

resource "aws_iam_role" "iam_role" {
  name                = var.role_name
  managed_policy_arns = [aws_iam_policy.s3_read_access.arn]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "s3_read_access" {
  name = "s3_read_access"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:ListBucket"],
        Effect   = "Allow"
        Resource = [var.s3_bucket_arn, format("%s/*", var.s3_bucket_arn)]
      },
    ]
  })
}


# Outputs
output "iam_role_arn" {
  value = aws_iam_role.iam_role.arn
}

output "iam_profile_name" {
  value = aws_iam_instance_profile.iam_profile.name
}
