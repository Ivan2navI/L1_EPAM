#!/bin/bash
clear
echo "=========================================================="
echo "Installing Ansible"
echo "=========================================================="
echo
echo
echo "=========================================================="
echo "Install the required dependencies"
echo "----------------------------------------------------------"
    sudo apt-get install gpgv curl wget -y

echo
echo "Check version of Ansible from Default Upstream Repository."
echo "----------------------------------------------------------"
    sudo apt update -y
    apt-cache policy ansible -y
echo
echo "----------------------------------------------------------"
    sudo apt update -y
    sudo apt install ansible -y
echo

echo "Setting Up the Inventory File"
echo "----------------------------------------------------------"
    cd /
    cd /home/admin/
    mkdir ansible
    cd ansible
echo
echo "-------------------       hosts     ----------------------"
echo "----------------------------------------------------------"
cat << EOF > hosts
# !!! hosts !!!

[Node1]
ip-192-168-11-11    ansible_hosts=192.168.11.11 ansible_user=admin ansible_ssh_private_key_file=/home/admin/.ssh/L1_Fin_Node1.pem

[Node2]
ip-192-168-11-12    ansible_hosts=192.168.11.12 ansible_user=ubuntu ansible_ssh_private_key_file=/home/admin/.ssh/L1_Fin_Node2.pem

[Node3]
ip-192-168-11-13    ansible_hosts=192.168.11.13 ansible_user=admin ansible_ssh_private_key_file=/home/admin/.ssh/L1_Fin_Node1.pem

[Node4]
ip-192-168-11-14    ansible_hosts=192.168.11.14 ansible_user=ubuntu ansible_ssh_private_key_file=/home/admin/.ssh/L1_Fin_Node2.pem

[prod:children]
Node1
Node2

[staging:children]
Node3
Node4

[debian:children]
Node1
Node3

[ubuntu:children]
Node2
Node4

[db_servers:children]
Node1
Node2
Node3
Node4
EOF

echo
echo "-------------------   ansible.cfg   ----------------------"
echo "----------------------------------------------------------"
cat << EOF > ansible.cfg
##############################
# !!! ansible.cfg !!!
[defaults]
host_key_checking = false
inventory = ./hosts
##############################
EOF

echo
echo "------   Ansible-galaxy (geerlingguy.mysql)   ------------"
echo "----------------------------------------------------------"
    cd /
    cd /home/admin/
    ansible-galaxy install geerlingguy.mysql  -p roles
echo
echo "=========================================================="

echo
echo
echo "=========================================================="
echo "SSH Connect"
echo "----------------------------------------------------------"
echo
read -p "Copy SSH keys to .shh & Press 'Enter' to continue..."
echo

    cd /
    cd /home/admin/
    chown -R admin:admin .ssh
    cd .ssh
    chmod 400 *.pem
echo
read -p "Run: ssh admin@192.168.11.xx -i X.keys & Then 'Enter' to continue..."
echo
#    ssh admin@192.168.11.11 -i L1_Fin_Node1.pem
#    ssh ubuntu@192.168.11.12 -i L1_Fin_Node2.pem
#    ssh admin@192.168.11.13 -i L1_Fin_Node1.pem
#    ssh ubuntu@192.168.11.14 -i L1_Fin_Node2.pem
echo "=========================================================="
echo
echo
echo "=========================================================="
echo "Ansible PING/PONG"
echo "----------------------------------------------------------"
    cd $HOME/ansible
    ansible -i hosts all -m ping
echo "=========================================================="
#################################
# exit
#################################