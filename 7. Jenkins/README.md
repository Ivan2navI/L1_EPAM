# 7. Jenkins

## 1. [How to Install OpenJDK 18 on Ubuntu 22.04 LTS](https://www.linuxcapable.com/how-to-install-openjdk-18-on-ubuntu-22-04-lts/)

The Jenkins project performs a full test flow with the following JDK/JREs:
- OpenJDK JDK / JRE 11 - 64 bits
- OpenJDK JDK / JRE 17 - 64 bits

```bash
sudo apt update && sudo apt upgrade -y

apt-cache search openjdk

sudo apt-get install openjdk-17-jdk -y

java --version

# Updates are handled with the standard apt update and upgrade commands. 
# However, you can remove them separately or altogether if you no longer require JDK or JRE.

Example:
sudo apt-get autoremove openjdk-17-jdk --purge -y
```

## 2. [Installing Jenkins](https://www.jenkins.io/doc/book/installing/linux/)

On Debian and Debian-based distributions like Ubuntu you can install Jenkins through apt.  
A LTS (Long-Term Support) release is chosen every 12 weeks from the stream of regular releases as the stable release for that time period. It can be installed from the debian-stable apt repository.  
```console
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install jenkins

sudo cat /var/lib/jenkins/secrets/initialAdminPassword == a6bfxxxxxx7d0a84bca880xxxxxxxxxxxx
```
__Jenkins to show the UI in English language?__

1. Download and install the locale plugin:
- From the main page of Jenkins, go to Manage Jenkins -> Manage Plugins
- Click on Availables
- Check the "Locale plugin" and clicks on "Download now and install after restart".

Jenkins will download the plugin and restart if not job has been scheduled.

2. Once the plugin has been installed, change the language using following steps:
- From the main page of Jenkins, go to Manage Jenkins -> Configure System.
- Under Locale, there will be a field called "Default Language". Enter the new language. It could be "en" or "ENGLISH".
- Under the text box, check the checkBox called "Ignore browser preference and force this language to all users".

<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/7.%20Jenkins/.info/1.1.png">
</p>

## 3. Create Simple Job 
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/7.%20Jenkins/.info/3.Create_Simple_Job.png">
</p>

## 4. Deploy from Jenkins over SSH
### 4.1. [Install the Apache Web Server on Main Jenkins Server](https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-22-04)
```console
# Step 1 — Installing Apache
sudo apt update
sudo apt install apache2

# Step 2 — Adjusting the Firewall
sudo ufw app list

# Your output will be a list of the application profiles:
#
# Output
# Available applications:
#  Apache
#  Apache Full
#  Apache Secure
#  OpenSSH

# As indicated by the output, there are three profiles available for Apache:
# 	- Apache: This profile opens only port 80 (normal, unencrypted web traffic)
# 	- Apache Full: This profile opens both port 80 (normal, unencrypted web traffic) and port 443 (TLS/SSL encrypted traffic)
# 	- Apache Secure: This profile opens only port 443 (TLS/SSL encrypted traffic)

# It is recommended that you enable the most restrictive profile that will still allow the traffic you’ve configured. Since you haven’t configured SSL for your server yet in this guide, you’ll only need to allow traffic on port 80:
sudo ufw allow 'Apache'

# You can verify the change by checking the status:
sudo ufw status

# Step 3 — Checking your Web Serve
# Make sure the service is active by running the command for the systemd init system:
sudo systemctl status apache2

# Step 4 — Managing the Apache Process
sudo systemctl stop apache2

sudo systemctl start apache2

sudo systemctl restart apache2

sudo systemctl reload apache2

sudo systemctl disable apache2

sudo systemctl enable apache2
```
Create a sample `index.html`:
```html

sudo nano /var/www/html/index.html

# add the following sample HTML:
<html>
    <head>
        <title>Welcome to Jenkins MAIN Server!</title>
    </head>
        
    <body>
      <center>
            <p style="text-align:center">
              <h1>Welcome to Jenkins MAIN Server!</h1>
              <h2>L1 EPAM</h2>
              <a href="http://jenkins1van.myddns.me:8080/">Jenkins MAIN Server</a>
            </p>
            <p style="text-align:center">
              <a href="http://jenkins0agent1van.myddns.me">Agent for Jenkins</a>
            </p>
            <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/7.%20Jenkins/.info/Jenkins_MAIN.png" alt="Jenkins" class="center">
      </center>
    </body>
</html>
```

### 4.2. Install the Apache Web Server for Jenkins Agent
Use the information from the previous paragraph and create a sample `index.html`:
```html
sudo nano /var/www/html/index.html

# add the following sample HTML:
<html>
    <head>
        <title>Welcome to AGENT!</title>
    </head>
        
    <body>
      <center>
            <p style="text-align:center">
              <h1 style="background-color:powderblue;">Welcome to Jenkins AGENT!</h1>
              <h2>L1 EPAM</h2>
            </p>

            <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/7.%20Jenkins/.info/Jenkins_Agent.png" alt="Jenkins Agent" class="center">
      </center>
    </body>
</html>
```

### 4.3. Deploy from Jenkins MAIN Server to Jenkins Agent over SSH
<p align="center">
  <img src=".info/4.3.Deploy_over_SSH.png">
</p>

Check SSH status on bouth servers. 
And connect from Jenkins MAIN Server [192.168.11.11] to Jenkins Agent [192.168.11.12] over SSH:
```console
# Evaluate OpenSSH Status
sudo systemctl status ssh

# The Ubuntu systems ships with default UFW firewall, If the UFW is active, you need to allow SSH port 22 for remote users. To allow port 22 in UFW type:
sudo ufw allow 22/tcp 


# !!!!!!!! ------- Connect to Jenkins Agent [192.168.11.12] over SSH ------- !!!!!!!! :
# !!! Add new user with password !!!: 
sudo useradd -m -d /home/jenkins_agent -s /bin/bash jenkins_agent
sudo passwd jenkins_agent

# Change user:
su jenkins_agent
cd ~

# Create a .ssh directory in the new_user home directory:
mkdir /home/jenkins_agent/.ssh

# ensure the directory ir owned by the new user
# chown -R username:username /home/username/.ssh
chown -R jenkins_agent:jenkins_agent /home/jenkins_agent/.ssh

# Use the chmod command to change the .ssh directory's permissions to 700. Changing the permissions restricts access so that only the new_user can read, write, or open the .ssh directory.
# chmod 700 /home/username/.ssh
chmod 700 /home/jenkins_agent/.ssh

# Use the touch command to create the authorized_keys file in the .ssh directory:
# touch /home/username/.ssh/authorized_keys
touch /home/jenkins_agent/.ssh/authorized_keys

# Use the chmod command to change the .ssh/authorized_keys file permissions to 600. Changing the file permissions restricts read or write access to the new_user.
# chmod 600 /home/username/.ssh/authorized_keys
chmod 600 /home/jenkins_agent/.ssh/authorized_keys


# !!!!!!!! ------- Generate SSH keys on Jenkins MAIN Server [192.168.11.11] over SSH ------- !!!!!!!! :

ubuntu@ip-192-168-11-11:~$ cd /home/ubuntu/.ssh/
ubuntu@ip-192-168-11-11:~/.ssh$ ssh-keygen
# Generating public/private rsa key pair.
# Enter file in which to save the key (/home/ubuntu/.ssh/id_rsa):
# Enter passphrase (empty for no passphrase):
# Enter same passphrase again:
Your identification has been saved in /home/ubuntu/.ssh/id_rsa
Your public key has been saved in /home/ubuntu/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:YmX/m9un4ugZSslg2A9dNZDxqjs3hD1nW8ryefaIidQ ubuntu@ip-192-168-11-11
The key's randomart image is:
+---[RSA 3072]----+
|          o+o    |
|          .o .   |
|        o . .    |
|     o + o .     |
|    . B Soo      |
|     o *.o+oo .  |
|        *.o=E+   |
|       ..++==Bo..|
|        o+==X=++.|
+----[SHA256]-----+

# Use the ssh-copy-id command for connect to Jenkins Agent [192.168.11.12] with user `jenkins_agent`:

scp ~/.ssh/id_rsa.pub jenkins_agent@192.168.11.12:~/.ssh/authorized_keys


ssh-copy-id jenkins_agent@192.168.11.12
# OR
ssh-copy-id -i ~/.ssh/id_rsa.pub jenkins_agent@192.168.11.12

scp ~/.ssh/id_rsa.pub ubuntu@192.168.11.12:~/.ssh/authorized_keys

ssh-copy-id -i ~/.ssh/id_rsa.pub ubuntu@192.168.11.12

```










---
### PS: [Paste to Markdown](https://euangoddard.github.io/clipboard2markdown/)

Instructions

    Find the text to convert to Markdown (e.g., in another browser tab)
    Copy it to the clipboard (Ctrl+C, or ⌘+C on Mac)
    Paste it into this window (Ctrl+V, or ⌘+V on Mac)
    The converted Markdown will appear!

The conversion is carried out by [to-markdown](https://github.com/domchristie/to-markdown), a Markdown converter written in JavaScript and running locally in the browser.