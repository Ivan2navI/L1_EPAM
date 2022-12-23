# 10. :a:nsible

## 1. Tech Environment for Ansible Project

<p align="center">
  <img src="./.info/Schem/AWS Ansible.png">
</p>

### [The Terraform configuration below:](https://github.com/Ivan2navI/L1_EPAM/tree/main/10.%20Ansible/home_task)
➢ Creates an Internet Gateway and attaches it to the VPC to allow traffic within the VPC to be reachable by the outside world;  
➢ Creates a public subnet;  
➢ Creates a route table for the public subnet and associates the table with the subnet;  
➢ Creates EC2 instances;
<p align="center">
  <img src="./.info/1.Tech_Environment_for_Ansible.png">
</p>

## [2. Install and Configure :a:nsible on Ubuntu 22.04 & Amazon Linux](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-22-04)

- **Ansible Server (Control Node): [192.168.11.10]** Ubuntu 22.04.1 LTS  
  The Ansible control node is the machine we’ll use to connect to and control the Ansible hosts over SSH.
- One or more Ansible Hosts:  
  An Ansible host is any machine that your Ansible control node is configured to automate.  
  - **Ansible Node1: [192.168.11.11]** Ubuntu 22.04.1 LTS 
  - **Ansible Node2: [192.168.11.12]** Amazon Linux 2 Kernel 5.10 AMI 2.0.20221210.1 

### 2.1. Installing Ansible
To begin using Ansible as a means of managing your server infrastructure, you need to install the Ansible software on the machine that will serve as the Ansible control node.
From your control node, run the following command to include the official project’s PPA (personal package archive) in your system’s list of sources:
```console
sudo apt-add-repository ppa:ansible/ansible

sudo apt update

sudo apt install ansible

# Check version
ansible --version

ansible [core 2.13.7]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/ubuntu/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/ubuntu/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.10.6 (main, Nov  2 2022, 18:53:38) [GCC 11.3.0]
  jinja version = 3.0.3
  libyaml = True
```
### 2.2. Setting Up the Inventory File



```console
ubuntu@ip-192-168-11-10:~/.ssh$   chmod 400 ansible_node1.pem ansible_node2.pem

ubuntu@ip-192-168-11-10:~/.ssh$   ssh ubuntu@192.168.11.11 -i ~/.ssh/ansible_node1.pem

ubuntu@ip-192-168-11-10:~/.ssh$   ssh ec2-user@192.168.11.12 -i ~/.ssh/ansible_node2.pem
```