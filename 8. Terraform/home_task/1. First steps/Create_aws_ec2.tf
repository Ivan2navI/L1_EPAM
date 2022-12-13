/* 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Add exception to .gitingnore file:

\8. Terraform\home_task* 
!8. Terraform\home_task\1. First steps\Create_aws_ec2.tf
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/


# Select cloud provider: AWS
provider "aws" {
    region = "eu-west-3"
}

# Amazon Linux 2 Kernel 5.10 AMI 2.0.20221103.3 x86_64 HVM gp2: 
# ami-0f15e0a4c8d3ee5fe
# -------------------------------------------------------------
# Virtual server type (instance type)
# t2.micro

resource "aws_instance" "Fisrt_Step_create_Amazone_Linux" {
    ami           = "ami-0f15e0a4c8d3ee5fe"
    instance_type = "t2.micro"

    tags = {
        Name    = "Amazon Linux"
        Owner   = "DevOps Student"
        Project = "Terraform (L1 EPAM)"
    }
}

/* 
# Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2022-12-01: 
# ami-03b755af568109dc3
# -------------------------------------------------------------
# Virtual server type (instance type)
# t2.micro

resource "aws_instance" "Fisrt_Step_create_Ubuntu_22.04" {
    ami           = "ami-0f15e0a4c8d3ee5fe"
    instance_type = "t2.micro"

    tags = {
        Name    = "Ubuntu 22.04 LTS"
        Owner   = "DevOps Student"
        Project = "Terraform (L1 EPAM)"
    }
}
*/