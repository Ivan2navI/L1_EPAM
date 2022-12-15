# Terraform configuration

provider "aws" {
  region = var.region
}

module "vpc" {
  source  = var.source_vpc
  version = var.source_vpc_version

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  # enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}

module "ec2_instances" {
  source  = var.source_aws
  version = var.source_aws_version

  name  = var.ec2_instances_name
  count = var.ec2_instances_count

  # ami                    = "ami-0c5204531f799e0c6"
  
  # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  # ami-0f15e0a4c8d3ee5fe (64-bit (x86))
  # instance_type: "t2.micro"
  ami           = var.ami_amazon_linux
  instance_type = var.instance_type 

  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = merge (var.commom_tags, {Name = var.ec2_instances_name}, {Region  = var.region})
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