#!/bin/bash
echo
echo "=========================================================="
echo "Before installing Jenkins, will be to install" 
echo "other required dependencies on your server"
echo "(apt-transport-https gnupg2 curl wget software-properties-common ca-certificates)" 
echo "and Java."
echo "=========================================================="
echo
echo "sudo apt update"
echo "----------------------------------------------------------"
sudo apt update
echo
echo "sudo apt install ... other required dependencie"
echo "----------------------------------------------------------"
sudo apt install apt-transport-https gnupg2 curl wget software-properties-common ca-certificates -y
echo "=========================================================="
echo
echo

# Install Java SDK 11
echo "=========================================================="
echo "Install Java SDK 11"
echo "=========================================================="
echo
echo "sudo apt install -y openjdk-11-jdk"
echo "----------------------------------------------------------"
sudo apt install -y openjdk-11-jdk
echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" | sudo tee -a /etc/environment
source /etc/environment
echo "----------------------------------------------------------"

echo "java --version ==>"
java --version
echo "----------------------------------------------------------"

echo "JAVA_HOME ==>" $JAVA_HOME
echo "=========================================================="
echo

