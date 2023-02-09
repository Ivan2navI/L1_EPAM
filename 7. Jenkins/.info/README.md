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
xxx

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

# The command installs a packages `make` & `gcc`.
apt-get update
apt install make 
apt install make gcc -y

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

# ------------------------------------
# Update Credentials
cd /usr/local/src/noip-2.1.9-1
sudo rm -r /usr/local/bin/noip2
sudo make
# --> make: 'noip2' is up to date.
sudo make install
# 	if [ ! -d /usr/local/bin ]; then mkdir -p /usr/local/bin;fi
# 	if [ ! -d /usr/local/etc ]; then mkdir -p /usr/local/etc;fi
# 	cp noip2 /usr/local/bin/noip2
# 	/usr/local/bin/noip2 -C -c /tmp/no-ip2.conf

#	Auto configuration for Linux client of no-ip.com.

#	Please enter the login/email string for no-ip.com  your_mail@mail.com
#	Please enter the password for user 'your_mail@mail.com'  ********

# ------------------------------------
# !! Add an executable (noip2) as a service !!
# Create `noip2.service` in `/etc/systemd/system`
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

## [SSH'ing into AWS EC2 Instance located in Private Subnet in a VPC](https://stackoverflow.com/questions/52816990/sshing-into-aws-ec2-instance-located-in-private-subnet-in-a-vpc)
[Использование Amazon EC2 Instance Connect для доступа к вашим EC2-инстансам по SSH](https://aws.amazon.com/ru/blogs/rus/using-amazon-ec2-instance-connect-for-ssh-access-to-your-ec2/)

[How to Connect Public and private subnet in same VPC](https://cloudiofy.com/how-to-connect-public-and-private-subnet-in-same-vpc/)

SSH to private server from public server and Install MySQL database
(https://cloudiofy.com/how-to-connect-ec2-instance-in-a-private-subnet/#SSH_to_private_server_from_public_server_and_Install_MySQL_database)

The 1st option to consider for SSH access to EC2 instances is [EC2 Instance Connect](https://aws.amazon.com/blogs/compute/new-using-amazon-ec2-instance-connect-for-ssh-access-to-your-ec2-instances/) which allows you to control access to your EC2 instances using IAM and provides access from either the AWS console or your regular command line SSH tools.

The 2nd option is [AWS Systems Manager Session Manager for Shell Access to EC2 Instances](https://aws.amazon.com/blogs/aws/new-session-manager/). You basically run an SSH session in your browser and it can target all EC2 instances, regardless of public/private IP or subnet. EC2 instances have to be running an up to date version of the SSM Agent and must have been launched with an appropriate IAM role (including the key policies from AmazonEC2RoleForSSM). No need for a bastion host or firewall rules allowing inbound port 22.

The 3rd option to consider is [AWS Systems Manager Run Command](https://docs.aws.amazon.com/systems-manager/latest/userguide/execute-remote-commands.html) which allows you to run commands remotely on your EC2 instances. It's not interactive like SSH but if you simply want to run a sequence of scripts then it's very good. Again, the instance has to be running the SSM Agent and have an appropriate IAM policy, and this option avoids the need to tunnel through bastion hosts.

Finally, if you really must SSH from your office laptop to an EC2 instance in a private subnet, you can do so via a bastion host. You need a few things:

1.  IGW and NAT in the VPC
2.  bastion host with public IP in the VPC's public subnet
3.  security group on the bastion allowing inbound SSH from your laptop
4.  a default route from the private subnet to the NAT
5.  security group on the private EC2 instance that allows inbound SSH from the bastion

Then you have to tunnel through the bastion host. See [Securely Connect to Linux Instances Running in a Private Amazon VPC](https://aws.amazon.com/blogs/security/securely-connect-to-linux-instances-running-in-a-private-amazon-vpc/) for more.

##### !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
##### ============================ NOT USED ====================================
!!!!!!!! ------- Connect to Jenkins Agent [192.168.11.12] over SSH ------- !!!!!!!! :
!!! Add new user with password !!!: 

```console
# Evaluate OpenSSH Status
sudo systemctl status ssh

# The Ubuntu systems ships with default UFW firewall, If the UFW is active, you need to allow SSH port 22 for remote users. To allow port 22 in UFW type:
sudo ufw allow 22/tcp 

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
##### ============================ ======== ====================================
##### !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
