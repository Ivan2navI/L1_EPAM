#!/bin/bash
clear
# First, navigate to the /tmp directory: cd /tmp
      cd /
      cd /tmp
echo
echo "=========================================================="
echo "Download Tomcat archive and unpack to `tomcat /usr/local/tomcat/`"
echo "=========================================================="

echo "sudo wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.27/bin/apache-tomcat-10.0.27.tar.gz"
echo "----------------------------------------------------------"
# Download the archive using wget by running the following command.
# Then, extract the archive you downloaded:
      sudo wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.27/bin/apache-tomcat-10.0.27.tar.gz
      tar -xvf apache-tomcat-10.0.27.tar.gz
      cd /
      mv /tmp/apache-tomcat-10.0.27 /usr/local/tomcat/
      #mv tomcat /opt/
echo "=========================================================="
echo
echo
echo "=========================================================="
echo "Create a dedicated user"
echo "----------------------------------------------------------"
echo
# Create a dedicated user
# For security purposes, Tomcat should run under a separate, unprivileged user. Run the following command to create a user called tomcat:
sudo useradd -m -d /usr/local/tomcat -U -s /bin/false tomcat
# By supplying /bin/false as the user's default shell, you ensure that it's not possible to log in as tomcat.
echo "=========================================================="
echo
echo
echo "=========================================================="
echo "Assigning Tomcat user permissions"
echo "----------------------------------------------------------"
echo
# Assigning Tomcat user permissions
# Since you have already created a user, you can now grant tomcat ownership over the extracted installation by running:
      cd /
      sudo chown -R tomcat:tomcat /usr/local/tomcat/tomcat
      sudo chmod -R u+x usr/tomcat/bin
echo "=========================================================="
echo
echo
echo "=========================================================="
echo "Check that listens ports"
echo "----------------------------------------------------------"
      ss -ltn
echo "----------------------------------------------------------"
echo "!!! In our case, port 8080 is already occupied by Jenkins?"
echo "=========================================================="
echo
echo
echo "=========================================================="
echo "Change connector port='8080'"
echo "=========================================================="
echo
# Change connector port="8080" port to any other port number, for example 8090. Save the server.xml.
echo "Backuping... /usr/local/tomcat/conf/server.xml"
echo "----------------------------------------------------------"
      cd /
      cp /usr/local/tomcat/conf/server.xml /usr/local/tomcat/conf/server_backup_`date +%Y_%m_%d__%H.%M.%S`.xml
      ls -alF /usr/local/tomcat/conf | grep server
echo
echo "Check, that the port='8080' present in server.xml"
echo "----------------------------------------------------------"
      cat /usr/local/tomcat/conf/server.xml | grep "port=\"8080\""
echo
echo "Replacing port='8090' ..."
echo "----------------------------------------------------------"
      sed -i 's/8080/8090/' /usr/local/tomcat/conf/server.xml
echo
echo "Check, that the port='8090' present in server.xml"
echo "----------------------------------------------------------"
      cat /usr/local/tomcat/conf/server.xml | grep "port=\"8090\""
echo
echo "Allow traffic to 8090 port"
echo "----------------------------------------------------------"
      sudo ufw allow 8090
echo
echo "Check that listens ports"
echo "----------------------------------------------------------"
      ss -ltn
echo "=========================================================="
echo
echo
echo "=========================================================="
echo "Set Admin/Manager username and password"
echo "=========================================================="

echo "Look on '/usr/local/tomcat/conf/tomcat-users.xml'"
echo "----------------------------------------------------------"
      cd /
      cat /usr/local/tomcat/conf/tomcat-users.xml | grep -E '<user rolename|<user username'
echo "----------------------------------------------------------"
echo "Backuping... /usr/local/tomcat/conf/tomcat-users.xml "
echo "----------------------------------------------------------"
      cd /
      cp /usr/local/tomcat/conf/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users_backup_`date +%Y_%m_%d__%H.%M.%S`.xml
      ls -alF /usr/local/tomcat/conf | grep tomcat-users_
echo
echo "Enter Admin name:"
echo "----------------------------------------------------------"
#check admin_name
read admin_name
  until [ ! -z "$admin_name" ]
  do
    echo "Please, Enter Admin name:"
    read admin_name
  done

echo
echo "Enter password for Admin:"
echo "----------------------------------------------------------"
#check admin_pass
read admin_pass
  until [ ! -z "$admin_pass" ]
  do
    echo "Please, Enter password for Admin:"
    read admin_pass
  done

echo
echo "Enter Manager name:"
#check manager_name
read manager_name
  until [ ! -z "$manager_name" ]
  do
    echo "Please, Enter Manager name:"
    read manager_name
  done

echo
echo "Enter password for Manager:"
echo "----------------------------------------------------------"
#check manager_pass
read manager_pass
  until [ ! -z "$manager_pass" ]
  do
    echo "Please, Enter password for Manager:"
    read manager_pass
  done

cd /usr/local/tomcat/conf/
# This step is important, without performing it we will get an error: "403 Access Denied on Tomcat 10/9/8 error" as we click on "Server Status", "Manager App" and "Host Manager" links on the Apache Tomcat Web interface.

# Edit user configuration file: sudo nano /usr/local/tomcat/conf/tomcat-users.xml
# Comment out the line </tomcat-users>
sed -i 's%</tomcat-users>%<!-- </tomcat-users> -->%g' tomcat-users.xml

# At the end just before </tomcat-users> tag copy and paste the following lines. 
tee -a tomcat-users.xml << EOF

<role rolename="manager-gui" />
<user username="$manager_name" password="$manager_pass" roles="manager-gui,manager-script" />

<role rolename="admin-gui" />
<user username="$admin_name" password="$admin_pass" roles="admin-gui,admin-script,manager-gui,manager-script" />

</tomcat-users>
EOF
echo      

echo "Remove the restriction for the Manager page"
echo "----------------------------------------------------------"
echo
echo "Backuping... /usr/local/tomcat/webapps/manager/META-INF/context.xml"
echo "----------------------------------------------------------"
      cd /
      cp /usr/local/tomcat/webapps/manager/META-INF/context.xml /usr/local/tomcat/webapps/manager/META-INF/context_`date +%Y_%m_%d__%H.%M.%S`.xml
      ls -alF /usr/local/tomcat/webapps/manager/META-INF/ | grep context_
# To remove the restriction for the Manager page, open its config file for editing:
# sudo nano /usr/local/tomcat/webapps/manager/META-INF/context.xml
# Comment out the line:
      sed -i 's%<Valve className="org.apache.catalina.valves.RemoteAddrValve"%<!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"%g' /usr/local/tomcat/webapps/manager/META-INF/context.xml
      sed -i 's%1" />%1" /> -->%g' /usr/local/tomcat/webapps/manager/META-INF/context.xml
echo
echo "Comment out the line: /usr/local/tomcat/webapps/manager/META-INF/context.xml"
      cat /usr/local/tomcat/webapps/manager/META-INF/context.xml | grep -E '<Valve className=|allow='
echo
echo "Remove the restriction for the Host Manager"
echo "----------------------------------------------------------"
echo
echo "Backuping... /usr/local/tomcat/webapps/host-manager/META-INF/context.xml"
echo "----------------------------------------------------------"
      cd /
      cp /usr/local/tomcat/webapps/host-manager/META-INF/context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context_`date +%Y_%m_%d__%H.%M.%S`.xml
      ls -alF /usr/local/tomcat/webapps/host-manager/META-INF | grep context_
# To remove the restriction for the Manager page, open its config file for editing:
# sudo nano /usr/local/tomcat/webapps/manager/META-INF/context.xml
# Comment out the line:
      sed -i 's%<Valve className="org.apache.catalina.valves.RemoteAddrValve"%<!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"%g' /usr/local/tomcat/webapps/host-manager/META-INF/context.xml
      sed -i 's%1" />%1" /> -->%g' /usr/local/tomcat/webapps/host-manager/META-INF/context.xml
echo
echo "Comment out the line: /usr/local/tomcat/webapps/host-manager/META-INF/context.xml"
      cat /usr/local/tomcat/webapps/host-manager/META-INF/context.xml | grep -E '<Valve className=|allow='
echo "=========================================================="
echo
echo
echo "=========================================================="
echo "=== Set Tomcat user permission {AGAIN = DONE } ==========="

# Set again Tomcat user permissions
      cd /
      sudo chown -R tomcat:tomcat /usr/local/tomcat/
      sudo chmod -R u+x /usr/local/tomcat/bin
      # ls -alF /usr/local/tomcat/conf
echo
echo
echo "=========================================================="
echo "Create a Systemd service file"
echo "=========================================================="
echo
cat << EOF
! Note:
!   In the above-given code for creating a systemd file, 
! we have to mention the path of Java. 
!   However, the given one in the above code is the default 
! path, still, to confirm the same you can run the below command:
! +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
! $ sudo update-java-alternatives -l
! java-1.11.0-openjdk-amd64      1111       /usr/lib/jvm/java-1.11.0-openjdk-amd64
EOF
echo
echo "Check a result =>"
echo "----------------------------------------------------------"
      sudo update-java-alternatives -l
echo
      read -p "Press 'Enter' to continue..."
echo

# You'll store the tomcat service in a file named tomcat.service, under /etc/systemd/system.
echo "Tomcat.service creating ..."
echo "----------------------------------------------------------"

sudo touch /etc/systemd/system/tomcat.service

sudo bash -c 'cat << EOF > /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat webs servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat
RestartSec=10
Restart=always 
Environment="JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

Environment="CATALINA_BASE=/usr/local/tomcat"
Environment="CATALINA_HOME=/usr/local/tomcat"
Environment="CATALINA_PID=/usr/local/tomcat/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/usr/local/tomcat/bin/startup.sh
ExecStop=/usr/local/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF'

echo
echo "Reload the systemd daemon"
echo "----------------------------------------------------------"
      sudo systemctl daemon-reload
echo
echo "Runnig the Tomcat service ..."
echo "----------------------------------------------------------"
      sudo systemctl start tomcat
echo  
echo "Enable Tomcat starting up with the system"
echo "----------------------------------------------------------"
      sudo systemctl enable tomcat      
echo
echo "Look at its status to confirm that it started successfully"
echo "----------------------------------------------------------"
      sudo systemctl status tomcat --no-pager -l
      read -p "Press 'Enter' to continue..." 
echo "=========================================================="
echo      
#################################
# exit
#################################
