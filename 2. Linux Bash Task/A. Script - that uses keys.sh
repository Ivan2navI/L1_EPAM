#!/bin/bash

clear

# Sometimes you need to pass a multiline text block to a command or variable. 
# Bash has a special type of redirect called Here document (heredoc) that allows you to do that

cat << EOF
# -----------------------------------------------------------------------------------------------------------
#						A. Script - that uses keys.sh
# -----------------------------------------------------------------------------------------------------------
# A. Create a script that uses the following keys: 
#     1. When starting without parameters, it will display a list of possible keys and their description.  
#     2. The --all key displays the IP addresses and symbolic names of all hosts in the current subnet  
#     3. The --target key displays a list of open system TCP ports. 
# The code that performs the functionality of each of the subtasks must be placed in a separate function
# -----------------------------------------------------------------------------------------------------------
EOF
echo


# ==================================== FUNCTIONS ====================================

func_check_avalible_lan_scans() {
  echo "====================== Lan Scans Check =============================="
  echo
  
  lan_scan_UPPER=('NMAP' 'MASSCAN' 'NETDISCOVER')
  lan_scan=('nmap' 'masscan' 'netdiscover')
  
  
  counter__lan_scan_UPPER=0
  
  for i in "${lan_scan[@]}"; do
    #echo $i
    #echo ${lan_scan_UPPER[counter__lan_scan_UPPER]}
   
    echo "------------- ${lan_scan_UPPER[counter__lan_scan_UPPER]} check -------------"
    check=`dpkg -s  $i | grep "Status"`
    if [ -n "$check" ]        #проверяем что нашли строку со статусом (что строка не пуста)
    then
       echo "${lan_scan_UPPER[counter__lan_scan_UPPER]} installed" #выводим результат
    else
       echo "${lan_scan_UPPER[counter__lan_scan_UPPER]} not installed, but can be installed with: sudo apt install $i"
    fi
    echo
  
    ((counter__lan_scan_UPPER++))
  done
  
  echo "===================================================================="
  echo
}


funct_INIT() {
    #Current IP address
    IP_is=$(hostname -I)
    #  echo "Current IP address: $IP_is"
    
    #Current CUT IP address
    IP_cut="`hostname -I | grep -Eo '([0-9]*\.){2}[0-9]*'`"
    #echo "Current CUT IP address: $IP_cut + * "
    IP_cut2=$IP_cut.*
    #echo "Current CUT2 IP address: $IP_cut2"
    
    #echo "`ls /sys/class/net | grep enp`" # Get LAN interfaces
    LAN_intf="`ls /sys/class/net | grep ^e`"
}


func_PING() {
  echo "------------- PING -----------------"
  echo "------------- ---- -----------------"
  for i in $(seq 1 254); do (ping -c1 $IP_cut.$i >/dev/null && echo "Host avalible: $IP_cut.$i" &); done
  sleep 2
  echo "------------- ---- -----------------"
  echo
}


func_NMAP() {
  echo "------------- NMAP -------------------------------------------------------------";
  echo "--------------------------------------------------------------------------------";
  echo "Current LAN: `ifconfig | grep broadcast | sed 's/       \s*//'`";
  echo "--------------------------------------------------------------------------------";
  echo "`nmap -sn $IP_cut2 | grep 'Nmap scan report for ' | sed 's/Nmap scan report for \s*//'`"; # Scan LAN for active HOSTS
  echo "--------------------------------------------------------------------------------";
  echo
}


func_MASSCAN() {
  echo "----------------- MASSCAN ------------------------------------------------"
  echo "--------------------------------------------------------------------------"
  echo "masscan $IP_cut.0/24 --ping --open-only"
  echo
  echo "`sudo masscan $IP_cut.0/24 --ping --open-only`"
  echo "--------------------------------------------------------------------------"
  echo
}


func_NETDISCOVER() {
  echo "------------- NETDISCOVER check -------------------"
  echo "---------------------------------------------------"
  echo "netdiscover -i $LAN_intf -r $IP_cut.0/24 -P"
  echo "`sudo netdiscover -i $LAN_intf -r $IP_cut.0/24 -P`"
  echo "---------------------------------------------------"
  echo
}


function_MAIN() {
  while :
  do 
    echo "Enter command [--all, --target, exit]"
    read cons_arg
    #echo "----->" 
    
    case $cons_arg in
      "--all")  echo;
                func_PING;
                func_NMAP;
                func_MASSCAN;
                func_NETDISCOVER;
                ;;
                #exit;;
                
      "--target")   echo;
                    echo "`nmap $IP_is`"; 
                    echo "----------------------------------------------------------------";
                    echo;
                    ;;
                    #exit;;
                    
      exit)     
                echo "------------------------------------";
                exit;;
                
      *)        echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
                echo "!! PLS, re-ENTER parameter !!";
                echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
                echo;
                ;;
    esac  
  done
}
# ==================================== ========= ====================================

# ====================================   MAIN    ====================================

func_check_avalible_lan_scans

funct_INIT

function_MAIN





