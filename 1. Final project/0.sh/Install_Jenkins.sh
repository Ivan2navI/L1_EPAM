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
echo

# Download and Install Jenkins
echo "=========================================================="
echo "Download and Install Jenkins"
echo "=========================================================="
echo
echo "Add Jenkins GPG key on Debian 11"
echo "----------------------------------------------------------"
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo
echo "Enable Jenkins repository on Bullseye"
echo "----------------------------------------------------------"
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
echo
echo "Run system update"
echo "----------------------------------------------------------"
sudo apt update -y
echo
echo "Install Jenkins on Debian 11"
echo "----------------------------------------------------------"
sudo apt install jenkins -y
echo
echo "Start Jenkins & Enable Jenkins to run on Boot"
echo "----------------------------------------------------------"
sudo systemctl start jenkins && sudo systemctl enable jenkins
echo
echo "Open link http://server-ip:8080 in the browser."
echo "And unlock Jenkins by adding admin password:" 
echo "----------------------------------------------------------"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "----------------------------------------------------------"
echo "=========================================================="
echo


