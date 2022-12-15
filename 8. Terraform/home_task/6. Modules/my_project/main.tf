provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "../modules/vpc"
  
  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  # enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}

  # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  # ami-0f15e0a4c8d3ee5fe (64-bit (x86))
  # instance_type: "t2.micro"

module "ec2_instances" {
  source  = "../modules/ec2_instances" 

  name           = var.ec2_instances_name
  instance_count = var.ec2_instances_count
  ami            = var.ami_amazon_linux
  instance_type  = var.instance_type 

  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = merge (var.commom_tags, {Name = var.ec2_instances_name}, {Region  = var.region})
}

