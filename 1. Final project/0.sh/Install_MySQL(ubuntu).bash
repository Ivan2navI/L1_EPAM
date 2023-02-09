#!/bin/bash
clear

echo "=========================================================="
echo "Install MySQL"
echo "=========================================================="

echo
echo "APT Update & get a list of Upgrades"
echo "----------------------------------------------------------"
# 1. Download MySQL server for your OS on VM. 
      sudo apt update
      sudo apt list --upgradable # get a list of upgrades
      sudo apt upgrade -y

echo
echo "Install MySQL v. 8.x"
echo "----------------------------------------------------------"
      sudo apt install mysql-server-8.0 -y

echo
echo "Add to MySQL => 'root'@'localhost' with password 'root';"
echo "----------------------------------------------------------"
      echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';" > DB_root_user
      sudo mysql < DB_root_user
      rm -r DB_root_user

echo
echo "Enabling the MySQL server at boot time"
echo "----------------------------------------------------------" 
  # Enabling the MySQL server at boot time
  # Make sure our MySQL server 8 starts when the system boots using the systemctl command:
sudo systemctl is-enabled mysql.service
  # If not enabled, type the following command to enable the server:
sudo systemctl enable mysql.service

  # Verify MySQL 8 server status on Ubuntu Linux 20.04 LTS by typing the following systemctl command:
sudo systemctl status mysql.service
echo "=========================================================="

#################################
# exit
#################################