# Input variable definitions
variable "region" {
  #region = "us-west-2"
  # Europe (Ireland)  eu-west-1
  # Europe (London)   eu-west-2
  # Europe (Paris)    eu-west-3
    
  description = "Configure the AWS Provider"
  type        = string
  default     = "eu-west-3"
}

variable "source_aws" {
  description = "terraform-aws-modules/ec2-instance/aws"
  type        = string
  default     = "terraform-aws-modules/ec2-instance/aws"  
}

variable "source_aws_version" {
  description = "version = 2.12.0"
  type        = string
  default     = "2.12.0"  
}

variable "source_vpc" {
  description = "terraform-aws-modules/vpc/aws"
  type        = string
  default     = "terraform-aws-modules/vpc/aws"  
}

variable "source_vpc_version" {
  description = "version = 2.21.0"
  type        = string
  default     = "2.21.0"  
}

variable "ec2_instances_name" {
  description = "Name of EC2 Instances"
  type        = string
  default     = "EC2 Instance"
} 

variable "ec2_instances_count" {
  description = "Count of EC2 Instances"
  type        = number
  default     = 2
} 

variable "instance_type" {
  description = "Enter Instance Type"
  type        = string
  default     = "t2.micro" 
}

variable "ami_amazon_linux" {
   description = "Amazon Machine Images: Amazon Linux 2 Kernel 5.10 AMI 2.0.20221103.3 x86_64 HVM gp2"
   type        = string
   default     = "ami-0f15e0a4c8d3ee5fe"
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "example-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  # default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
  
  # Europe (Ireland)  eu-west-1
  # Europe (London)   eu-west-2
  # Europe (Paris)    eu-west-3   Subnets can currently only be created in the following availability zones: eu-west-3a, eu-west-3b, eu-west-3c.
  default     = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

/*
variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
}
*/

variable "commom_tags" {
  description = "Common Tags to apply to all resources"
  type        = map(string)
  default     = {
    Name    = "EC2 & S3 bucket site (Modules_Task)"
    Owner   = "DevOps Student"
    Project = "Modules_Task (L1 EPAM)"
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}
