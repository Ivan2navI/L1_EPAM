# 8. Terraform

# 1. AWS Credentials Setup & Installation on Linux/Windows
<p align="center">
  <img src="./.info/1.1.AWS_Credentials_Setup.png">
</p>


```console
export AWS_ACCESS_KEY_ID=AKIAT4***************************
export AWS_SECRET_ACCESS_KEY_ID=dSdj**********************
terraform apply
```


Windows / Linux
https://developer.hashicorp.com/terraform/downloads
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform