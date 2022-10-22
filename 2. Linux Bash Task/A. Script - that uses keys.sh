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

#Current IP address
IP_is=$(hostname -I)
echo "Current IP address: $IP_is"

#Current CUT IP address
IP_cut="`hostname -I | grep -Eo '([0-9]*\.){2}[0-9]*'`"
echo "Current CUT IP address: $IP_cut"
IP_cut2=$IP_cut.*
echo "Current CUT2 IP address: $IP_cut2"
echo

#nmap -sn 192.168.2.* | grep -Eo '(for\.)'
nmap -sn $IP_cut2 | grep -Eo '(for\.)' # Сканировать сеть в поиске Активных Хостов

while :
do 
  echo "Enter command [--all, --target, exit]"
  read cons_arg
  #echo "----->" 
  
  case $cons_arg in
    #"--all")   echo "`nmap -sn -oG 'all_active_ip.log' 192.168.0.*`"; exit;;
    "--all")  echo "`ifconfig | grep broadcast`";
              nmap -sn $IP_cut2 | grep 'for'; # Сканировать сеть в поиске Активных Хостов
              exit;; 
    "--target")      echo "`nmap localhost`"; exit;; 
    exit)     exit;;
    *)        echo "PLS, re-ENTER parameter";;
  esac
  
  echo "------------------------------------"   
done
