# 2.3. Explicit dependencies example

# Europe (Paris): eu-west-3
# Select cloud provider: AWS
provider "aws" {
    region = "eu-west-3"
}

# Amazon Linux 2 Kernel 5.10 AMI 2.0.20221103.3 x86_64 HVM gp2: 
# ami-0f15e0a4c8d3ee5fe
# -------------------------------------------------------------
# Virtual server type (instance type)
# t2.micro

resource "aws_instance" "Web_Server_for_Explicit" {
    ami           = "ami-0f15e0a4c8d3ee5fe"
    instance_type = "t2.micro"                   

    tags = {
        Name    = "Web Server (4Explicit)"
        Owner   = "DevOps Student"
        Project = "Explicit dependencies example (L1 EPAM)"
    }
}

# Security Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

#Basic Usage

resource "aws_security_group" "Security_Group_4Explicit" {
  name        = "Security_Group_4Explicit"
  description = "Allow TLS inbound traffic"
  #vpc_id      = aws_vpc.main.id

  ingress {
    description      = "ingress Security_Group_4Explicit"
    from_port        = ["443", "80", "22"]
    to_port          = ["443", "80", "22"]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]   
    #cidr_blocks      = [aws_vpc.main.cidr_block]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Security_Group_4Explicit"
  }
}