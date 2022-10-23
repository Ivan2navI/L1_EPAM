#!/bin/bash

#clear
echo "------------------------------------"

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
#exit


echo "------------- NMAP check -------------"
#echo "`apt-cache policy nmap`"
NMAP=`dpkg -s  nmap | grep "Status"`
if [ -n "$NMAP" ]        #проверяем что нашли строку со статусом (что строка не пуста)
then
   echo "NMAP installed" #выводим результат
else
   echo "NMAP not installed, but can be installed with: sudo apt install nmap"
fi
echo

echo "------------- ZMAP check -------------"
#echo "`apt-cache policy zmap`"
ZMAP=`dpkg -s zmap | grep "Status"`
if [ -n "$ZMAP" ]        #проверяем что нашли строку со статусом (что строка не пуста)
then
   echo "ZMAP installed" #выводим результат
else
   echo "ZMAP not installed, but can be installed with: sudo apt install zmap"
fi
echo

echo "------------- MASSCAN check -------------"
#echo "`apt-cache policy masscan`"
MASSCAN=`dpkg -s masscan | grep "Status"`
if [ -n "$MASSCAN" ]        #проверяем что нашли строку со статусом (что строка не пуста)
then
   echo "MASSCAN installed" #выводим результат
else
   echo "MASSCAN not installed, but can be installed with: sudo apt install masscan"
fi
echo

echo "------------- NETDISCOVER check -------------"
#echo "`apt-cache policy netdiscover`"
NETDISCOVER=`dpkg -s netdiscover | grep "Status"`
if [ -n "$NETDISCOVER" ]        #проверяем что нашли строку со статусом (что строка не пуста)
then
   echo "NETDISCOVER installed" #выводим результат
else
   echo "NETDISCOVER not installed, but can be installed with: sudo apt install netdiscover"
fi
echo
echo "============================================="


#This will give you all IPv4 interfaces, including the loopback 127.0.0.1:
echo "All IPv4 interfaces:"
echo "`ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}'`"
echo "`ip -br l | awk '$1 !~ "lo|vir|wl" { print $1}'`"  # Get LAN interfaces
echo "`ls /sys/class/net | grep ^e`" # Get LAN interfaces V2
echo


#Current IP address
IP_is=$(hostname -I)
echo "Current IP address: $IP_is"

#Current CUT IP address
IP_cut="`hostname -I | grep -Eo '([0-9]*\.){2}[0-9]*'`"
echo "Current CUT IP address: $IP_cut"
echo


#Use grep to filter IP address from ifconfig
echo "Use grep to filter IP address from ifconfig"
ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
echo

# AND CUT to format 192.168.X 
echo "AND CUT to format 192.168.x"
ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){2}[0-9]*' | grep -Eo '([0-9]*\.){2}[0-9]*' | grep -v '127.0.0'
echo



echo "------------- PING -----------------"
IP=192.168.0
for i in $(seq 1 254); do (ping -c1 $IP.$i >/dev/null && echo "ON: $IP.$i" &); done
sleep 2

echo "----------- NEXT PING --------------"
IP=192.168.2
for i in $(seq 1 254); do (ping -c1 $IP.$i >/dev/null && echo "ON: $IP.$i" &); done
sleep 2
echo

#echo "------------- NEXT -----------------"
#for i2 in {1..254}; do (ping -c1 $IP.$i2 >/dev/null && echo "ON: $IP.$i2" &); done


echo "-------------- NMAP -----------------"
echo "nmap -sP 192.168.0.* | grep '(1'"
echo "`nmap -sP 192.168.0.* | grep '(1'`"
echo
echo "nmap -sP 192.168.2.* | grep '(1'"
echo "`nmap -sP 192.168.2.* | grep '(1'`"
echo

echo "----------- MASSCAN ----------------"
echo "masscan 192.168.0.0/24 --ping --open-only"
echo "`sudo masscan 192.168.0.0/24 --ping --open-only`"
echo
echo "masscan 192.168.2.0/24 --ping --open-only"
echo "`sudo masscan 192.168.2.0/24 --ping --open-only`"
echo

echo "------------- NETDISCOVER check -------------"
echo "netdiscover -i enp0s3 -r 192.168.0.0/24 -P"
echo "`sudo netdiscover -i enp0s3 -r 192.168.0.0/24 -P`"
echo "---------------------------------------------------"
echo
echo "netdiscover -i enp0s3 -r 192.168.2.0/24 -P" 
echo "`sudo netdiscover -i enp0s3 -r 192.168.2.0/24 -P`" 

#  https://github.com/snovvcrash/xakepru/blob/master/htb-reddish/ping-sweep.sh
#  https://habr.com/ru/company/vdsina/blog/499750/
#  https://jonathansblog.co.uk/zmap-on-a-local-network
#  https://manpages.ubuntu.com/manpages/xenial/man8/masscan.8.html
#  https://ru.stackoverflow.com/questions/141577/%D0%9F%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BA%D0%B0-%D0%BD%D0%B0%D0%BB%D0%B8%D1%87%D0%B8%D1%8F-%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BB%D0%B5%D0%BD%D0%BD%D0%BE%D0%B3%D0%BE-%D0%BF%D0%B0%D0%BA%D0%B5%D1%82%D0%B0-%D0%BD%D0%B0-bash




# "/etc/zmap/blacklist.conf"
# /etc/zmap/zmap.conf
# zmap -p 80 192.168.2.0/24 -B 100M -o zmap.txt


#  to scan with zmap on a local network for upnp hosts:

#  /usr/local/sbin/zmap -p 1900 192.168.0.0/16 -M upnp -b -o zmap.txt

#  to scan for DNS services

#  /usr/local/sbin/zmap -p 53 192.168.0.0/24 -b /dev/null

#  to scan for ssh services

#  /usr/local/sbin/zmap -p 22 192.168.0.0/24 -b /dev/null

#  to scan for http services

#  sudo zmap -p 80 192.168.0.0/16 -o zmap.txt

#10.0.0.0        -   10.255.255.255  (10/8 prefix)
#172.16.0.0      -   172.31.255.255  (172.16/12 prefix)
#192.168.0.0     -   192.168.255.255 (192.168/16 prefix)
