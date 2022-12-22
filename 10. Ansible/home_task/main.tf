# --------------------------------------------------------------------
# --------------------------------------------------------------------
# Tech Environment for Ansible Project
# --------------------------------------------------------------------
# --------------------------------------------------------------------


# Europe (Paris): eu-west-3
# Select cloud provider: AWS
provider "aws" {
    region = var.region                                                           # VAR region: "eu-west-3"
}

# --------------------------------------------------------------------
# Amazon Linux 2 Kernel 5.10 AMI 2.0.20221210.1 x86_64 HVM gp2: 
# ami-0cc814d99c59f3789
# --------------------------------------------------------------------
# Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2022-12-01
# ami-03b755af568109dc3
# --------------------------------------------------------------------
# Virtual server type (instance type)
# t2.micro
# --------------------------------------------------------------------
resource "aws_instance" "Server" {
    ami           = var.ami_server                                          
    instance_type = var.instance_type                                            
    
    #subnet_id              = aws_subnet.publicsubnets.id
    network_interface {
      network_interface_id = aws_network_interface.foo.id
      device_index         = 0
    }
    vpc_security_group_ids = [aws_security_group.Security_Group.id]                            
    associate_public_ip_address = true

    tags = merge (var.commom_tags, {Name = var.ec2_name1}, {Region  = var.region})                        # MERGE 2 VARIABLES: var.commom_tags(MAP TAGS) & var.region
}

resource "aws_instance" "Node1" {
    ami           = var.ami_node1                                                 
    instance_type = var.instance_type                                             
    
    #subnet_id              = aws_subnet.publicsubnets.id
    network_interface {
      network_interface_id = aws_network_interface.foo.id
      device_index         = 1
    }    
    vpc_security_group_ids = [aws_security_group.Security_Group.id]        
    associate_public_ip_address = true

    depends_on = [aws_instance.Server]

    tags = merge (var.commom_tags, {Name = var.ec2_name2}, {Region  = var.region})                           # MERGE 2 VARIABLES: var.commom_tags(MAP TAGS) & var.region 
}

resource "aws_instance" "Node2" {
    ami           = var.ami_node2                                      
    instance_type = var.instance_type                                            

    #subnet_id              = aws_subnet.publicsubnets.id
    network_interface {
      network_interface_id = aws_network_interface.foo.id
      device_index         = 2
    }
    vpc_security_group_ids = [aws_security_group.Security_Group.id]                                
    associate_public_ip_address = true

    depends_on = [aws_instance.Server]

    tags = merge (var.commom_tags, {Name = var.ec2_name3}, {Region  = var.region})                        # MERGE 2 VARIABLES: var.commom_tags(MAP TAGS) & var.region
}


# --------------------------------------------------------------------
# Create the VPC
 resource "aws_vpc" "Main" {                # Creating VPC here
/*   cidr_block       = var.main_vpc_cidr     # Defining the CIDR block use 192.168.11.0/27
   instance_tenancy = var.main_vpc_instance_tenancy
*/
  cidr_block       = "192.168.11.0/27"
  #instance_tenancy = "default"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main (VPC)"
  }
}

# Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "IGW" {    # Creating Internet Gateway
  vpc_id =  aws_vpc.Main.id               # vpc_id will be generated after we create VPC
  
  tags = {
    Name = "main (IGW)"
  }
}

# Create a Public Subnets.
resource "aws_subnet" "publicsubnets" {    # Creating Public Subnets
  vpc_id =  aws_vpc.Main.id
  #cidr_block = "${var.public_subnets}"        # CIDR block of public subnets
  cidr_block = "192.168.11.0/28"       # CIDR block of public subnets
  
  tags = {
    Name = "main (Public Subnet)"
  }
}

resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.publicsubnets.id
  private_ips = ["192.168.11.10", "192.168.11.11", "192.168.11.12"]

  tags = {
    Name = "Primary Network Interface"
  }
}

# Route table for Public Subnet
resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
  vpc_id =  aws_vpc.Main.id
  /*route {
    cidr_block = "192.168.11.0/28"            
    destination_prefix_list_id = "local"
  }*/
    
  route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
  }
  
  tags = {
    Name = "main (Route table for Public Subnet)"
  }
}
 
# Route table Association with Public Subnet
resource "aws_route_table_association" "PublicRTassociation" {
  subnet_id = aws_subnet.publicsubnets.id
  route_table_id = aws_route_table.PublicRT.id
} 

# --------------------------------------------------------------------
# Security Group
resource "aws_security_group" "Security_Group" {
  name = "main (Security_Group)"
  vpc_id = aws_vpc.Main.id

  dynamic "ingress" {
    for_each = var.allow_ports                                                  # VAR allow_ports: [ "80", "443", "22", "8080" ]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge (var.commom_tags, {Name = "Ansible_Security_Group"})
}