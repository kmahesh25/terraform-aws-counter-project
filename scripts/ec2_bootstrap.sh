#!/bin/bash

echo "Executing bootstrap script.."

# Variables
S3_BUCKET='ap-southeast-1-demo-counter-s3-bucket'
PROJECT_DIR='counter'
WEB_DIR='/var/lib/nginx/www/html'

# Update the instance with latest packages
sudo yum update -y

# Install utils
sudo yum install curl zip unzip -y

# Install aws cli
cd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
aws --version

# Install nginx
sudo amazon-linux-extras enable epel
sudo yum install epel-release -y
sudo yum install nginx -y

# Download nginx conf and project content
sudo mkdir -p ${WEB_DIR}
sudo aws s3 cp s3://${S3_BUCKET}/projects/${PROJECT_DIR}/index.html ${WEB_DIR}
sudo aws s3 cp s3://${S3_BUCKET}/projects/${PROJECT_DIR}/default.conf /etc/nginx/conf.d

sudo chmod 755 ${WEB_DIR}
sudo chmod 644 ${WEB_DIR}/*

# Enable and reload nginx
sudo systemctl enable nginx && sudo systemctl start nginx

# Validate nginx service
curl https://localhost

# Exit
exit 0
