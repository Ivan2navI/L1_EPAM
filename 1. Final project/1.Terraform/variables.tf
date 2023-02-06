# --------------------------------------------------------------------
# --------------------------------------------------------------------
# Tech Environment for Final Project
# --------------------------------------------------------------------
# --------------------------------------------------------------------

variable "service_name" {
  default = "Final Project"
}

# -------------------------------------------------------------------

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
   description = "Debian 11 (HVM), SSD Volume Type"
   type        = string
   default     = "ami-040dc155c278da35a"
}

variable "ami_node1" {
   description = "Debian 11 (HVM), SSD Volume Type"
   type        = string
   default     = "ami-040dc155c278da35a"
}

variable "ami_node2" {
   description = "Ubuntu Server 20.04 LTS (HVM), SSD Volume Type"
   type        = string
   default     = "ami-0a89a7563fc68be84"
}

variable "ami_node3" {
   description = "Debian 11 (HVM), SSD Volume Type"
   type        = string
   default     = "ami-040dc155c278da35a"
}

variable "ami_node4" {
   description = "Ubuntu Server 20.04 LTS (HVM), SSD Volume Type"
   type        = string
   default     = "ami-0a89a7563fc68be84"
}


variable "ec2_name1" {
    description = "EC2 name for instance 1"
    type        = string
    default     = "Main_Server"
}

variable "ec2_name2" {
    description = "EC2 name for instance 2"
    type        = string
    default     = "Node1_Prod (Debian)"
}

variable "ec2_name3" {
    description = "EC2 name for instance 3"
    type        = string
    default     = "Node2_Prod (Ubuntu)"
}

variable "ec2_name4" {
    description = "EC2 name for instance 4"
    type        = string
    default     = "Node1_Test (Debian)"
}

variable "ec2_name5" {
    description = "EC2 name for instance 5"
    type        = string
    default     = "Node2_Test (Ubuntu)"
}

# -------------------------  SSH keys  -------------------------------
variable "ec2_ssh_key1" {
    type        = string
    default     = "L1_Fin_Main_Server"
}

variable "ec2_ssh_key2" {
    type        = string
    default     = "L1_Fin_Node1"
}

variable "ec2_ssh_key3" {
    type        = string
    default     = "L1_Fin_Node2"
}

# --------------------------------------------------------------------

variable "ec2_private_ip1" {
    description = "EC2 name for instance 1"
    type        = string
    default     = "192.168.11.10"
}

variable "ec2_private_ip2" {
    description = "EC2 name for instance 2"
    type        = string
    default     = "192.168.11.11"
}

variable "ec2_private_ip3" {
    description = "EC2 name for instance 3"
    type        = string
    default     = "192.168.11.12"
}

variable "ec2_private_ip4" {
    description = "EC2 name for instance 2"
    type        = string
    default     = "192.168.11.13"
}

variable "ec2_private_ip5" {
    description = "EC2 name for instance 3"
    type        = string
    default     = "192.168.11.14"
}
# --------------------------------------------------------------------

variable "main_vpc_cidr" {
    type    = string
    default = "192.168.11.0/27"
 }
 
 variable "main_publicsubnets_cidr" {
    type    = string
    default = "192.168.11.0/28"
 }


# --------------------------------------------------------------------

variable "allow_ports" {
  description = "List of Ports to open for server"
  type        = list
  default     = [ "80", "443", "22", "8080", "8090", "8092" ]
  #default     = [ "80", "443", "22", "3306", "8080", "8090", "8092" ]
}

variable "commom_tags" {
  description = "Common Tags to apply to all resources"
  type        = map
  default     = {
    Name    = "Final Project"
    Owner   = "DevOps Student"
    Project = "Final Project (L1 EPAM)"
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
