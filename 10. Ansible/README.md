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

## 2. :a:nsible instalation

```console
ubuntu@ip-192-168-11-10:~/.ssh$ ssh ubuntu@192.168.11.11 -i ~/.ssh/ansible_node1.pem

ubuntu@ip-192-168-11-10:~/.ssh$ ssh ec2-user@192.168.11.12 -i ~/.ssh/ansible_node2.pem
```