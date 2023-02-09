#!/bin/bash
clear
# First, navigate to the usr/local/ directory: cd usr/local/
      cd /
      cd usr/local/
# In this case we need 2nd Tomcat server for testing web aplication. 
# So, stop fiest tomcat & copy it to tomcat2
echo
echo "=========================================================="
echo "Stop & disable Tomcat. Copy Tomcat to Tomcat2"
echo "=========================================================="
echo
echo "Stop & disable Tomcat."
echo "----------------------------------------------------------"
      sudo systemctl stop tomcat
      sudo systemctl disable tomcat
echo
echo "Copy Tomcat to Tomcat2"
echo "----------------------------------------------------------"
      sudo cp -r tomcat tomcat2

# For security purposes, Tomcat2 should run under a separate, 
# unprivileged user tomcat:      
echo
echo "Assigning Tomcat user permissions"
echo "----------------------------------------------------------"
      sudo chown -R tomcat:tomcat ./tomcat2
      sudo chmod -R u+x ./tomcat2/bin
echo
echo "ls -alF ./tomcat2"
echo "----------------------------------------------------------"      
      sudo ls -alF ./tomcat2
echo "=========================================================="
echo
echo
echo "=========================================================="
echo "Change connector port='8090' for Tomcat2"
echo "=========================================================="
echo
# Change connector port="8090" (from 1st tomcat) to any other port number, 
# for example 8092. Save the server.xml.
echo "Backuping... ./tomcat2/conf/server.xml"
echo "----------------------------------------------------------"
      #cd /
      cp ./tomcat2/conf/server.xml ./tomcat2/conf/server_backup_`date +%Y_%m_%d__%H.%M.%S`.xml
      ls -alF ./tomcat2/conf | grep server
echo
echo "Check, that the port='8090' (from 1st tomcat) present in server.xml"
echo "----------------------------------------------------------"
      cat ./tomcat2/conf/server.xml | grep "port=\"8090\""

# If you want to run multiple tomcat instances in parallel,
# it requires to change Server port for 'Shutdown'
# <Server port="8005" shutdown="SHUTDOWN">
echo
echo "Change Server port for 'Shutdown'"
echo "----------------------------------------------------------"
      cat ./tomcat2/conf/server.xml | grep "port=\"8005\""
echo
echo "Replacing port='8005' ..."
echo "----------------------------------------------------------"
      sed -i 's/8005/8006/' ./tomcat2/conf/server.xml
echo
echo "Check, that the port='8006' present in server.xml"
echo "----------------------------------------------------------"
      cat ./tomcat2/conf/server.xml | grep "port=\"8006\""
echo
echo "Replacing port='8090' ..."
echo "----------------------------------------------------------"
      sed -i 's/8090/8092/' ./tomcat2/conf/server.xml
echo
echo "Check, that the port='8092' present in server.xml"
echo "----------------------------------------------------------"
      cat ./tomcat2/conf/server.xml | grep "port=\"8092\""
echo
echo "Allow traffic to 8092 port"
echo "----------------------------------------------------------"
      sudo ufw allow 8092
echo
echo "Check that listens ports"
echo "----------------------------------------------------------"
      ss -ltn
echo "=========================================================="
echo
echo
echo "=========================================================="
echo "=== Set Tomcat user permission {AGAIN = DONE } ==========="

# Set again Tomcat user permissions
      sudo chown -R tomcat:tomcat ./tomcat2/
      sudo chmod -R u+x ./tomcat2/bin
      ls -alF ./tomcat2/conf
echo
echo
echo "=========================================================="
echo "Create a Systemd service file"
echo "=========================================================="
echo
# You'll store the tomcat service in a file named tomcat.service, under /etc/systemd/system.
echo "Tomcat.service creating ..."
echo "----------------------------------------------------------"

sudo touch /etc/systemd/system/tomcat2.service

sudo bash -c 'cat << EOF > /etc/systemd/system/tomcat2.service
[Unit]
Description=Tomcat2 webs servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat
RestartSec=10
Restart=always 
Environment="JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

Environment="CATALINA_BASE=/usr/local/tomcat2"
Environment="CATALINA_HOME=/usr/local/tomcat2"
Environment="CATALINA_PID=/usr/local/tomcat2/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/usr/local/tomcat2/bin/startup.sh
ExecStop=/usr/local/tomcat2/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF'

echo
echo "Reload the systemd daemon"
echo "----------------------------------------------------------"
      sudo systemctl daemon-reload
echo
echo "Runnig the Tomcat2 service ..."
echo "----------------------------------------------------------"
      sudo systemctl start tomcat2
echo  
echo "Enable Tomcat2 starting up with the system"
echo "----------------------------------------------------------"
      sudo systemctl enable tomcat2
echo
echo "Look at its status to confirm that it started successfully"
echo "----------------------------------------------------------"
      sudo systemctl status tomcat2 --no-pager -l
      read -p "Press 'Enter' to continue..." 
echo "=========================================================="
echo
echo
echo "=========================================================="
echo "Start Tomcat again (which has port 8090)"
echo "=========================================================="
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