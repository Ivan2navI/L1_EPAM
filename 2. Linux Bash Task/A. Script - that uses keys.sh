#						A. Script - that uses keys.sh
# -----------------------------------------------------------------------------------------------------------------
#	A. Create a script that uses the following keys: 
#		1. When starting without parameters, it will display a list of possible keys and their description.  
#		2. The --all key displays the IP addresses and symbolic names of all hosts in the current subnet  
#		3. The --target key displays a list of open system TCP ports. 
#	The code that performs the functionality of each of the subtasks must be placed in a separate function


#!/bin/bash
clear
echo "------------------------------------"

while :
do 
  echo "Enter command [--all, --target, exit]"
  read cons_arg
  #echo "----->" 
  
  case $cons_arg in
    #"--all")   echo "`nmap -sn -oG 'all_active_ip.log' 192.168.0.*`"; exit;;
    "--all")   echo "`ifconfig | grep broadcast`";
                echo "`nmap -sP 192.168.0.* | grep '(1'`"; # Сканировать сеть в поиске Активных Хостов
                exit;; 
    "--target")      echo "`nmap localhost`"; exit;; 
    exit)     exit;;
    *)        echo "PLS, re-ENTER parameter";;
  esac
  
  echo "------------------------------------"   
done
