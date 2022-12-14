# 8. Terraform

## 1. AWS Credentials Setup & Installation on Linux/Windows

### 1.1. Follow this steps to setup AWS Credentials:
<p align="center">
  <img src="./.info/1.1.AWS_Credentials_Setup.png">
</p>

Copy to secret place your access keys, :warning: pay attention to the fact AWS_SECRET_ACCESS_KEY_ID is displayed once :warning:.

Using environment variables to contain your credentials prevents you from accidentally sharing your AWS secret access key. We recommend that you never add your AWS access keys directly to the client in any production files. Many developers have had their account compromised by leaked keys.

To authenticate to Amazon Web Services, the SDK first checks for credentials in your environment variables. The SDK uses the getenv() function to look for the AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and AWS_SESSION_TOKEN environment variables. These credentials are referred to as environment credentials.

```console
# Set credentials on:
# => Linux
export AWS_ACCESS_KEY_ID="AKIAT4***************************"
export AWS_SECRET_ACCESS_KEY_ID="dSdj**********************"

## Region Europe (Frankfurt) eu-central-1
export AWS_DEFAULT_REGION="eu-central-1"

# --------------------------------------------------------
# => Windows:

C:\> SET  AWS_ACCESS_KEY_ID=AKIAT4***********************
   # The access key for your AWS account.
C:\> SET  AWS_SECRET_ACCESS_KEY=dSdj*********************
   # The secret access key for your AWS account.

## Region Europe (Frankfurt) eu-central-1
C:\> SET  AWS_DEFAULT_REGION=eu-central-1
```

### 1.2. Installing on Linux/Windows
Use this [link](https://developer.hashicorp.com/terraform/downloads) to select your actual OS.  

In my case for **Linux (Ubuntu)**, [this installation option worked](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).  
Check results:
```console
terraform --version
#   Terraform v1.3.6
#   on linux_amd64
```
There are two installation options for Windows:
First option => Download archive, unpack `teterraform.exe` to `C:\Windows\System32` and check `C:\Windows\System32` in Command Prompt.
<p align="center">
  <img src="./.info/1.2.Setup_Windows_v1.png">
</p>
Second option => Download archive, unpack `teterraform.exe` for example `C:\Terraform`.  
Use `Win+R` and `sysdm.cpl` to add new eviroment variable:
<p align="center">
  <img src="./.info/1.2.Setup_Windows_v2.png">
</p>

## 2. [Terraform. First steps.](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build?in=terraform%2Faws-get-started)
For testing I will use region Europe (Paris): `eu-west-3`  

In Windows Command Prompt set credentials:
```console
C:\> SET  AWS_ACCESS_KEY_ID=AKIAT4***********************
   # The access key for your AWS account.
C:\> SET  AWS_SECRET_ACCESS_KEY=dSdj*********************
   # The secret access key for your AWS account.
```

### 2.1. Create  project folder and `.tf` file there: *Create_aws_ec2.tf*.
```console
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
        Name = "Amazon Linux"
        Owner = "DevOps Student"
        Project = "Terraform (L1 EPAM)"
    }
}

```
:warning: Add exception to .gitingnore file: :warning: 
```console
\8. Terraform\home_task* 
!8. Terraform\home_task\1. First steps\Create_aws_ec2.tf
```

Run in this folder [Winows Command Prompt] with command: `terraform init`.  
Then wait for dowloading (AWS) provider plugins (~ 325Mb).  
<p align="center">
  <img src="./.info/2.1.terraform_init.png">
</p>

Next, command: `terraform plan`.  
If configuration of EC2 instances correct, enter: `terraform apply`  
<p align="center">
  <img src="./.info/2.1.terraform_init2.png">
</p>

Add one more EC2 & check results:  
```console
# Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2022-12-01: 
# ami-03b755af568109dc3
# -------------------------------------------------------------
# Virtual server type (instance type)
# t2.micro

resource "aws_instance" "Fisrt_Step_create_Ubuntu_2204" {
    ami           = "ami-0f15e0a4c8d3ee5fe"
    instance_type = "t2.micro"

    tags = {
        Name = "Ubuntu 22.04 LTS"
        Owner = "DevOps Student"
        Project = "Terraform (L1 EPAM)"
    }
}
```
<p align="center">
  <img src="./.info/2.1.terraform_init3.png">
</p>

Now delete one of instances: `terraform destroy --target aws_instance.Fisrt_Step_create_Amazone_Linux`  
or cut/comment code one of them from `.tf` file.  
<p align="center">
  <img src="./.info/2.1.1.terraform_destroy.png">
</p>

Delete all instances: `terraform destroy`  
<p align="center">
  <img src="./.info/2.1.2.terraform_destroy_all.png">
</p>

### 2.2. Use Count for create and destroy EC2.
Add paramentr `count = 2` to add 2 (or more) identical EC2's:
```console
# Select cloud provider: AWS
provider "aws" {
    region = "eu-west-3"
}

# Amazon Linux 2 Kernel 5.10 AMI 2.0.20221103.3 x86_64 HVM gp2: 
# ami-0f15e0a4c8d3ee5fe
# -------------------------------------------------------------
# Virtual server type (instance type)
# t2.micro

resource "aws_instance" "Count_Amazone_Linux" {
    count         = 2                           # to add 2 (or more) identical EC2's 
    ami           = "ami-0f15e0a4c8d3ee5fe"
    instance_type = "t2.micro"                   

    tags = {
        Name    = "Amazon Linux (Count)"
        Owner   = "DevOps Student"
        Project = "Terraform (L1 EPAM)"
    }
}
```
Next, command: `terraform plan`.  
If configuration of EC2 instances correct, enter: `terraform apply`

If you want delete one of instances, you can change `count=1`,  
if change `count=0` - that delete all instances.  
But, you can also use: `terraform destroy`.
<p align="center">
  <img src="./.info/2.2.Use_Count.png">
</p>

### 2.3. Explicit dependencies example
In this task was created two EC2 instances ["Web Server (4Explicit)", "Data Base Server (4Explicit)"]  
&  Security Group ["Security_Group_4Explicit"].  
In addition, the following dependency has been added - "Database Server (4 Explicit)" must be created before "Web Server (4Explicit)".  
Source code [link](https://github.com/Ivan2navI/L1_EPAM/blob/main/8.%20Terraform/home_task/3.%20Explicit%20dependencies%20example/Explicit%20dependencies%20example.tf)  
<p align="center">
  <img src="./.info/2.3.Explicit_dependencies_examplepng.png">
</p>

**To complete the task - execute:** `terraform destroy`.  
The destruction order will be as follows:
<p align="center">
  <img src="./.info/2.3.Explicit_dependencies_examplepng_2.png">
</p>

### 2.4. Variables
In this task, most of the variables have been moved to a separate file `variables.tf`.  
Source code [(link)](https://github.com/Ivan2navI/L1_EPAM/tree/main/8.%20Terraform/home_task/4.%20Variables).
<p align="center">
  <img src="./.info/2.4.Variables.png">
</p>

### 2.5. Outputs
In this task, you must first create an `otputs.tf` file.  
Copy File `main.tf` and `variables.tf` from the pre-project and run the following commands:  
```console 
terraform init
terraform plan
terraform apply
```
Show all variants wich we can use, for creating `otputs.tf`:   
`terraform show`

Source code [(link)](https://github.com/Ivan2navI/L1_EPAM/tree/main/8.%20Terraform/home_task/5.%20Outputs).
<p align="center">
  <img src="./.info/2.5.Outputs.png">
</p>

`https://spacelift.io/blog/how-to-destroy-terraform-resources  
Step 3 – Destroy Protected Resources  
Step 4 – Destroy All Except a Few  `