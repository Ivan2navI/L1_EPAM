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
A LTS (Long-Term Support) release is chosen every 12 weeks from the stream of regular releases as the stable release for that time period. It can be installed from the debian-stable apt repository. \
```console
	curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee
	  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
	echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
	  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
	  /etc/apt/sources.list.d/jenkins.list > /dev/null
	sudo apt-get update
	sudo apt-get install jenkins
```