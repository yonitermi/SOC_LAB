variable "aws_region"    { default = "us-east-1" }
variable "ami_id"        { description = "AMI ID for Ubuntu" }
variable "instance_type" { default = "t3.medium" }
variable "key_name"      { description = "EC2 SSH key name" }
variable "vpc_id"        { description = "VPC ID" }
