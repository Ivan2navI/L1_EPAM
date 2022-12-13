
# Select cloud provider: AWS
provider "aws" {
    region = "eu-west-3"
}

# Amazon Linux 2 Kernel 5.10 AMI 2.0.20221103.3 x86_64 HVM gp2: 
# ami-0f15e0a4c8d3ee5fe
# -------------------------------------------------------------
# Virtual server type (instance type)
# t2.micro

resourse "aws_instance" "1.Fisrt_Step_create_EC2" {
    ami           = "ami-0f15e0a4c8d3ee5fe"
    instance_type = "t2.micro"
}