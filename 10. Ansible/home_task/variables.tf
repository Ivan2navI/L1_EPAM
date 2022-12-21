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

variable "ami_ubuntu" {
   description = "Amazon Machine Images: Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2022-12-01"
   type        = string
   default     = "ami-03b755af568109dc3"
}

variable "ec2_name1" {
    description = "EC2 name for instance 1"
    type        = string
    default     = "Web Server (5_Outputs_Task)"
}

variable "ec2_name2" {
    description = "EC2 name for instance 2"
    type        = string
    default     = "Data Base (5_Outputs_Task)"
}

variable "allow_ports" {
  description = "List of Ports to open for server"
  type        = list
  default     = [ "80", "443", "22", "8080" ]
}

variable "commom_tags" {
  description = "Common Tags to apply to all resources"
  type        = map
  default     = {
    Name    = "Web Server (5_Outputs_Task)"
    Owner   = "DevOps Student"
    Project = "Outputs_Task (L1 EPAM)"
  }
}
