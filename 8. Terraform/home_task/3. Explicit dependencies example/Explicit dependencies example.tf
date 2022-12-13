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

