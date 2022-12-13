# 8. Terraform

# 1. AWS Credentials Setup & Installation on Linux/Windows

## 1.1. Follow this steps to setup AWS Credentials:
<p align="center">
  <img src="./.info/1.1.AWS_Credentials_Setup.png">
</p>

Copy to secret place your access keys, :warning: pay attention to the fact AWS_SECRET_ACCESS_KEY_ID is displayed once :warning:.
```console
# Set credentials on:
# => Linux
export AWS_ACCESS_KEY_ID="AKIAT4***************************"
export AWS_SECRET_ACCESS_KEY_ID="dSdj**********************"

## Region Europe (Frankfurt) eu-central-1
export AWS_DEFAULT_REGION="eu-central-1"

# --------------------------------------------------------
# => Windows:
$env:AWS_ACCESS_KEY_ID="AKIAT4***************************"
$env:AWS_SECRET_ACCESS_KEY_ID="dSdj**********************"

## Region Europe (Frankfurt) eu-central-1
$env:AWS_DEFAULT_REGION="eu-central-1"
```

## 1.2. Installing on Linux/Windows
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