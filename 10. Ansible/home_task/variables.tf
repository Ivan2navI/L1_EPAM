# --------------------------------------------------------------------
# --------------------------------------------------------------------
# Tech Environment for Ansible Project
# --------------------------------------------------------------------
# --------------------------------------------------------------------


# Europe (Paris): eu-west-3
variable "region" {
  description = "Configure the AWS Provider"
  type        = string
  default     = "eu-west-3"
}

# --------------------------------------------------------------------

variable "instance_type" {
  description = "Enter Instance Type"
  type        = string
  default     = "t2.micro" 
}

variable "ami_server" {
   description = "Amazon Machine Images: Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2022-12-01"
   type        = string
   default     = "ami-03b755af568109dc3"
}

variable "ami_node1" {
   description = "Amazon Machine Images: Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2022-12-01"
   type        = string
   default     = "ami-03b755af568109dc3"
}


variable "ami_node2" {
   description = "Amazon Machine Images: Amazon Linux 2 Kernel 5.10 AMI 2.0.20221210.1 x86_64 HVM gp2"
   type        = string
   default     = "ami-0cc814d99c59f3789"
}

variable "ec2_name1" {
    description = "EC2 name for instance 1"
    type        = string
    default     = "Ansible_Server"
}

variable "ec2_name2" {
    description = "EC2 name for instance 2"
    type        = string
    default     = "Ansible_Node1_Ubuntu"
}

variable "ec2_name3" {
    description = "EC2 name for instance 3"
    type        = string
    default     = "Ansible_Node2_Amazon_Linux"
}

# --------------------------------------------------------------------

variable "allow_ports" {
  description = "List of Ports to open for server"
  type        = list
  default     = [ "80", "443", "22", "8080" ]
}

variable "commom_tags" {
  description = "Common Tags to apply to all resources"
  type        = map
  default     = {
    Name    = "Ansible"
    Owner   = "DevOps Student"
    Project = "Ansible (L1 EPAM)"
  }
}

# --------------------------------------------------------------------
/*
 variable "main_vpc_cidr" {
   main_vpc_cidr = "192.168.11.0/27"
 }
 
 variable "main_vpc_instance_tenancy" {
   instance_tenancy = "default"
 }
  variable "vpc_tag" {
    Name = "AWS VPC main"
  }

 variable "public_subnets" {
  public_subnets = "192.168.11.0/28"
 }
*/
