#!/bin/bash
clear

cat << EOF
# "=========================================================="
#  ! ! ! ! ! ! ! ! ! ! ! ! ATTENTION ! ! ! ! ! ! ! ! ! ! ! ! 
#  !                Uninstall old versions                 !
# "----------------------------------------------------------"
# Older versions of Docker went by the names of docker, 
# docker.io, or docker-engine. Uninstall any such older 
# versions before attempting to install a new version?
# "=========================================================="
EOF
echo
      read -p "Press 'Enter' to continue..." 

echo
echo
RELISE=`( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1`
echo "OS Version =>" $RELISE

echo
echo "=========================================================="
echo "Install Docker Engine on Debian && Ubuntu"
echo "=========================================================="
echo
echo "Update the apt package index and install packages to allow apt to use a repository over HTTPS:"
echo "----------------------------------------------------------"
      sudo apt-get update
      sudo apt-get install\
            ca-certificates\
            curl\
            gnupg\
            lsb-release
echo
echo "Add Docker's official GPG key"
echo "----------------------------------------------------------"
      sudo mkdir -p /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo
echo "Set up the repository:"
echo "----------------------------------------------------------"
case "$RELISE" in
  Ubuntu*)  echo "UBUNTU" 
            echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  ;;
  Debian*)  echo "DEBIAN" 
            echo\
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian\
            $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null  
  ;; 
  *)        echo "unknown OS: $RELISE"
            echo "Bye! :("
            exit
  ;;
esac

echo
echo "Update the apt package index:"
echo "----------------------------------------------------------"
sudo apt-get update

echo
echo "Install Docker Engine, containerd, and Docker Compose."
echo "----------------------------------------------------------"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

echo
echo "Verify that the Docker Engine installation is successful by running the 'hello-world' image:"
echo "----------------------------------------------------------"
sudo docker run hello-world
echo "=========================================================="
#################################
exit
#################################
