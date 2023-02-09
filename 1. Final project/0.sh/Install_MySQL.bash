#!/bin/bash
clear

# First, navigate to the /tmp directory: cd /tmp
cd /tmp

echo
echo "=========================================================="
echo "Install MySQL"
echo "=========================================================="
echo
echo "Download MySQL v. 8.22-1"
echo "----------------------------------------------------------"
      sudo apt install wget -y
      wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb
echo
echo "Install the MySQL repository via the APT package manager"
echo "----------------------------------------------------------"
echo
cat << EOF
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# At this point, we will be asked to choose the MySQL Server version we prefer. 
# In this scenario, we are opting for mysql-8.0.  
# Then choose **OK** and press *Enter* key. 
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
EOF
read -p "Press 'Enter' to continue..." 

# Install the MySQL repository via the APT package manager
sudo apt install ./mysql-apt-config_*_all.deb
echo "----------------------------------------------------------"
echo
cat << EOF
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Again select Ok and press the Enter key.
# After installing the package, mysql.list will be added to /etc/apt/source.list.d/.
# After adding the repository, we have to run the system update command 
# as seen below in order to rebuild the cache and install MySQL on Debian Bullseye:
#     sudo apt update
#     sudo apt install mysql-server
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
EOF
      read -p "Press 'Enter' to continue..."
echo
      sudo apt update
      sudo apt install mysql-server
echo "----------------------------------------------------------"
echo      
echo "Start automatically at system boot MySQL server service"
echo "----------------------------------------------------------"
      sudo systemctl enable --now mysql
echo      
echo "Check the status of the MySQL server servicer"
echo "----------------------------------------------------------"
      systemctl status mysql      
echo "=========================================================="
echo      
#################################
# exit
#################################