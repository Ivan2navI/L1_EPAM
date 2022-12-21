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

    vpc_security_group_ids = [aws_security_group.Security_Group.id]                                

    tags = merge (var.commom_tags, {Name = var.ec2_name1}, {Region  = var.region})                        # MERGE 2 VARIABLES: var.commom_tags(MAP TAGS) & var.region
}

resource "aws_instance" "Node1" {
    ami           = var.ami_node1                                                 
    instance_type = var.instance_type                                             

    vpc_security_group_ids = [aws_security_group.Security_Group.id]        

    depends_on = [aws_instance.Server]

    tags = merge (var.commom_tags, {Name = var.ec2_name2}, {Region  = var.region})                           # MERGE 2 VARIABLES: var.commom_tags(MAP TAGS) & var.region 
}

resource "aws_instance" "Node2" {
    ami           = var.ami_node2                                      
    instance_type = var.instance_type                                            

    vpc_security_group_ids = [aws_security_group.Security_Group.id]                                

    depends_on = [aws_instance.Server]
    
    tags = merge (var.commom_tags, {Name = var.ec2_name3}, {Region  = var.region})                        # MERGE 2 VARIABLES: var.commom_tags(MAP TAGS) & var.region
}

# --------------------------------------------------------------------
# Security Group
resource "aws_security_group" "Security_Group" {
  name = "Security_Group"

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