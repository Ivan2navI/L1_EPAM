============================ 1 ========================== \
	How to Install OpenJDK 18 on Ubuntu 22.04 LTS

Jenkins Java requirements 
https://www.jenkins.io/doc/administration/requirements/java/

The Jenkins project performs a full test flow with the following JDK/JREs:

    OpenJDK JDK / JRE 11 - 64 bits

    OpenJDK JDK / JRE 17 - 64 bits


https://www.linuxcapable.com/how-to-install-openjdk-18-on-ubuntu-22-04-lts/

sudo apt update && sudo apt upgrade -y

apt-cache search openjdk

sudo apt-get install openjdk-17-jdk -y

java --version

Updates are handled with the standard apt update and upgrade commands. 
However, you can remove them separately or altogether if you no longer require JDK or JRE.

Example:
sudo apt-get autoremove openjdk-17-jdk --purge -y

============================ 2 ========================== \
			Installing Jenkins

https://www.jenkins.io/doc/book/installing/linux/
```console
Ошибки установки: 
systemctl status jenkins.service

journalctl -xeu jenkins.service
			The job identifier is 4976.
			лис 09 17:55:57 ubuntu-VirtualBox jenkins[7883]: jenkins: invalid Java version: openjdk version "18.0.2-ea" 2022-07-19
			лис 09 17:55:57 ubuntu-VirtualBox jenkins[7883]: OpenJDK Runtime Environment (build 18.0.2-ea+9-Ubuntu-222.04)
			лис 09 17:55:57 ubuntu-VirtualBox jenkins[7883]: OpenJDK 64-Bit Server VM (build 18.0.2-ea+9-Ubuntu-222.04, mixed mode, sharing)
			лис 09 17:55:57 ubuntu-VirtualBox systemd[1]: jenkins.service: Main process exited, code=exited, status=1/FAILURE
```
Debian/Ubuntu

On Debian and Debian-based distributions like Ubuntu you can install Jenkins through apt.
Long Term Support release

A LTS (Long-Term Support) release is chosen every 12 weeks from the stream of regular releases as the stable release for that time period. It can be installed from the debian-stable apt repository. \
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
```console
	curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee
	  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
	echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
	  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
	  /etc/apt/sources.list.d/jenkins.list > /dev/null
	sudo apt-get update
	sudo apt-get install jenkins
```
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

------> Weekly release <------

A new release is produced weekly to deliver bug fixes and features to users and plugin developers. It can be installed from the debian apt repository.

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
```console
	curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
	  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
	
	echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
	  https://pkg.jenkins.io/debian binary/ | sudo tee \
	  /etc/apt/sources.list.d/jenkins.list > /dev/null
	
	sudo apt-get update
	sudo apt-get install jenkins
```	
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Beginning with Jenkins 2.335 and Jenkins 2.332.1, the package is configured with systemd rather than the older System V init. See the DigitalOcean community systemd tutorial to better understand the benefits of systemd and the systemctl command.

The package installation will:

    Setup Jenkins as a daemon launched on start. Run systemctl cat jenkins for more details.

    Create a ‘jenkins’ user to run this service.

    Direct console log output to systemd-journald. Run journalctl -u jenkins.service if you are troubleshooting Jenkins.

    Populate /lib/systemd/system/jenkins.service with configuration parameters for the launch, e.g JENKINS_HOME

    Set Jenkins to listen on port 8080. Access this port with your browser to start configuration.

	

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
============================ 3 ========================== \
		Plugin Manager
- Dashboard  
	View Customizable dashboard that can present various views of job information. 

- Workspace Cleanup  
	This plugin deletes the project workspace when invoked. 

- JUnit  
	Allows JUnit-format test results to be published. 

- Pipeline  
	A suite of plugins that lets you orchestrate automation, simple or complex. See Pipeline as Code with Jenkins for more details. 

- Parameterized Trigger  
	This plugin lets you trigger new builds when your build has completed, with various ways of specifying parameters for the new build. 

- Copy Artifact  
	Adds a build step to copy artifacts from another project. 

- Git  
	This plugin integrates Git with Jenkins. 

- Matrix Project  
	Multi-configuration (matrix) project type. 

- SSH Build Agents  
	Allows to launch agents over SSH, using a Java implementation of the SSH protocol. 

- WMI Windows Agents  
	Allows you to setup agents on Windows machines over Windows Management Instrumentation (WMI) 

============================ 4 ========================== \
Admin_Jenkins
Test.2022

Admin Jenkins
Admin_Jenkins@test.net
http://192.168.2.12:8080/

============================ 5 ========================== \
	Jenkins to show the UI in English language?
		
1. Download and install the locale plugin:

    From the main page of Jenkins, go to Manage Jenkins -> Manage Plugins
    Click on Availables
    Check the "Locale plugin" and clicks on "Download now and install after restart".

Jenkins will download the plugin and restart if not job has been scheduled.

2. Set the language:

Once the plugin has been installed, change the language using following steps:

    From the main page of Jenkins, go to Manage Jenkins -> Configure System.

    Under Locale, there will be a field called "Default Language". Enter the new language. It could be "en" or "ENGLISH".

    Under the text box, check the checkBox called "Ignore browser preference and force this language to all users".


============================ 6 ========================== \
## JENKINS AWS
### [Install & Configure NoIP](https://thanoskoutr.com/posts/noip2-install-and-service-commands/)
No-IP is a Free Dynamic DNS and Managed DNS Provider, that we can use to get a free domain name. There a lot of free Dynamic DNS services, you can find a good comprehensive of them here that we can choose from, but this was the first service that I personally tried.

The good with this service is that we have a big selection of free domain names that we can choose, so we can easily find a domain that is available for the hostname we want to have.

The negative is that every 30 days they send a notification email, and we have to sign in to www.noip.com and confirm that we still use the hostname. After some time that I have used the service, I can say that it becomes annoying to verify it once every month.
```console
# Login as root
sudo su

# Type the following commands:
cd /usr/local/src/
wget http://www.noip.com/client/linux/noip-duc-linux.tar.gz
tar xf noip-duc-linux.tar.gz
cd noip-2.1.9-1/
make
make install

# On the configuration stage:
#    => Add email and password.
#    => The hostname to update (choose only one).

# To launch the client
/usr/local/bin/noip2

# !! Add an executable (noip2) as a service !!
# Create noip2.service in /etc/systemd/system
# And add the following:

[Unit]
Description=No-Ip Dynamic DNS Update Service
After=network.service

[Service]
Type=forking
ExecStart=/usr/local/bin/noip2

[Install]
WantedBy=default.target

# ------------------------------------
# Restart systemctl to accept changes
sudo systemctl daemon-reload

# Enable service
sudo systemctl enable noip2

# Start service
sudo systemctl start noip2

# Restart service
# !! With a restart, it updates the public IP:
sudo systemctl restart noip2

# Get status
sudo systemctl status noip2

# See logs
sudo journalctl -u noip2
```
