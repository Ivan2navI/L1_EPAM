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