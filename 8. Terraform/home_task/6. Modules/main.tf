# Terraform configuration

provider "aws" {
  #region = "us-west-2"

  # Europe (Ireland)  eu-west-1
  # Europe (London)   eu-west-2
  # Europe (Paris)    eu-west-3

  region = "eu-west-3"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  # enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}

module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.12.0"

  name           = "my-ec2-cluster"
  instance_count = 2

  # ami                    = "ami-0c5204531f799e0c6"
  
  # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  # ami-0f15e0a4c8d3ee5fe (64-bit (x86))
  ami                    = "ami-0f15e0a4c8d3ee5fe"
  instance_type          = "t2.micro"


  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

/*
module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"

  #bucket_name = "<UNIQUE BUCKET NAME>"
  bucket_name = "L1 EPAM DevOPS"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
*/