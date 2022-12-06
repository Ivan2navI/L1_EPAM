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
Installation errors:
```console
systemctl status jenkins.service

journalctl -xeu jenkins.service
			The job identifier is 4976.
			лис 09 17:55:57 ubuntu-VirtualBox jenkins[7883]: jenkins: invalid Java version: openjdk version "18.0.2-ea" 2022-07-19
			лис 09 17:55:57 ubuntu-VirtualBox jenkins[7883]: OpenJDK Runtime Environment (build 18.0.2-ea+9-Ubuntu-222.04)
			лис 09 17:55:57 ubuntu-VirtualBox jenkins[7883]: OpenJDK 64-Bit Server VM (build 18.0.2-ea+9-Ubuntu-222.04, mixed mode, sharing)
			лис 09 17:55:57 ubuntu-VirtualBox systemd[1]: jenkins.service: Main process exited, code=exited, status=1/FAILURE
```

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
```

If Jenkins fails to start because a port is in use, run systemctl edit jenkins and add the following:
```console
[Service]
Environment="JENKINS_PORT=8081"

Here, "8081" was chosen but you can put another port available.
Installation of Java

sudo systemctl status jenkins
● jenkins.service - Jenkins Continuous Integration Server
	 Loaded: loaded (/lib/systemd/system/jenkins.service; enabled; vendor preset: enabled)
	 Active: active (running) since Wed 2022-11-09 18:19:25 EET; 3min 13s ago
   Main PID: 5029 (java)
	  Tasks: 38 (limit: 4626)
	 Memory: 380.2M
		CPU: 37.982s
	 CGroup: /system.slice/jenkins.service
			 └─5029 /usr/bin/java -Djava.awt.headless=true -jar /usr/share/java/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080

лис 09 18:18:55 ubuntu-VirtualBox jenkins[5029]: a6bf48e7d0a84bca880c17b218042c59
лис 09 18:18:55 ubuntu-VirtualBox jenkins[5029]: This may also be found at: /var/lib/jenkins/secrets/initialAdminPassword

httpPort=8080

sudo cat /var/lib/jenkins/secrets/initialAdminPassword == a6bf48e7d0a84bca880c17b218042c59
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
