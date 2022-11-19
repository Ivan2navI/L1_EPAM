# 4. Linux Networking
## INTRO
Практична частина модуля Linux Networking  передбачає створення засобами Virtual Box мережі, що показаний на рисунку 1
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/INTRO.Pic_1.png">
</p>
  
__Host__ – це комп’ютер, на якому запущений Virtual Box;

__Server_1__ – Віртуальна машина, на якій розгорнуто ОС Linux. Int1 цієї машини в режимі «Мережевий міст» підключений до мережі Net1, тобто знаходиться в адресному просторі домашньої мережі. IP-адреса Int1 встановлюється статично відповідно до адресного простору, наприклад 192.168.1.200/24. Інтерфейси Int2 та Int3 відповідно підключено в режимі «Внутрішня мережа» до мереж Net2 та Net3. 

__Client_1 та Client_2__ – Віртуальні машини, на яких розгорнуто ОС Linux (бажано різні дистрибутиви, наприклад Ubuntu та CentOS). Інтерфейси підключені в режимі «Внутрішня мережа» до мереж Net2, Net3 та Net4 як показано на рисунку 1. 

Адреса мережі Net2 – 10.Y.D.0/24, де Y – дві останні цифри з вашого року народження, D – дата народження.   
Адреса мережі Net3 – 10.M.Y.0/24, де M – номер місяця народження. \
Адреса мережі Net4 – 172.16.D.0/24.

1. На Server_1 налаштувати статичні адреси на всіх інтерфейсах. 
2. На Server_1 налаштувати DHCP сервіс, який буде конфігурувати адреси Int1, Client_1 та Client_2 
3. За допомогою команд ping та traceroute перевірити зв'язок між віртуальними машинами. Результат пояснити. \
__Увага!__ Для того, щоб з Client_1 та Client_2 проходили пакети в мережу Internet (точніше щоб повертались з Internet на Client_1 та Client_2) на Wi-Fi Router необхідно налаштувати статичні маршрути для мереж Net2 та Net3. Якщо такої можливості немає інтерфейс Int1 на Server_1 перевести в режим NAT. 
4. На віртуальному інтерфейсу lo Client_1 призначити дві ІР адреси за таким правилом: 172.17.D+10.1/24 та 172.17.D+20.1/24. Налаштувати маршрутизацію таким чином, щоб трафік з Client_2 до 172.17.D+10.1 проходив через Server_1, а до 172.17.D+20.1 через Net4. Для перевірки використати traceroute. 
5. Розрахувати спільну адресу та маску (summarizing) адрес 172.17.D+10.1 та 172.17.D+20.1, при чому префікс має бути максимально можливим. Видалити маршрути, встановлені на попередньому кроці та замінити їх об’єднаним маршрутом, якій має проходити через Server_1. 
6. Налаштувати SSH сервіс таким чином, щоб Client_1 та Client_2 могли підключатись до Server_1 та один до одного.  
7. Налаштуйте на Server_1 firewall таким чином:
- Дозволено підключатись через SSH з Client_1 та заборонено з Client_2 
- З Client_2 на 172.17.D+10.1 ping проходив, а на 172.17.D+20.1 не проходив 
8. Якщо в п.3 була налаштована маршрутизація для доступу Client_1 та Client_2 до мережі Інтернет – видалити відповідні записи. На Server_1 налаштувати NAT 
сервіс таким чином, щоб з Client_1 та Client_2 проходив ping в мережу Інтернет.

## Preparing
__Server_1__ 
- Int1: 192.168.2.30/24. 

__Client_1 та Client_2__ \
Адреса мережі Net2 – 10.Y.D.0/24, де Y(85) – дві останні цифри з вашого року народження, D(8) – дата народження. \
Адреса мережі Net3 – 10.M.Y.0/24, де M(3) – номер місяця народження. \
Адреса мережі Net4 – 172.16.D.0/24

 - Net2: 10.85.8.0/24  
 - Net3: 10.3.85.0/24
 - Net4: 172.16.8.0/24

<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/My_Schem.png">
</p>

#### Add some packages
```console
sudo apt install vim net-tools traceroute tree ncdu bash-completion curl dnsutils htop iftop pwgen screen sudo wget nmon git mc

sudo apt install nmap masscan netdiscover network-manager
```

## Answers: 1, 2, 3.
### 1. На Server_1 налаштувати статичні адреси на всіх інтерфейсах.
### 2. На Server_1 налаштувати DHCP сервіс, який буде конфігурувати адреси Int1, Client_1 та Client_2.
### 3. За допомогою команд ping та traceroute перевірити зв'язок між віртуальними машинами. Результат пояснити.
### __Увага!__ Для того, щоб з Client_1 та Client_2 проходили пакети в мережу Internet (точніше щоб повертались з Internet на Client_1 та Client_2) на Wi-Fi Router необхідно налаштувати статичні маршрути для мереж Net2 та Net3. Якщо такої можливості немає інтерфейс Int1 на Server_1 перевести в режим NAT.

#### Linux Routing switch ON

• Switch on routing is needed only on transit devices. \
• To check out routing enable use
```console
ubuntu@server1:~$ sysctl net.ipv4.conf.all.forwarding
net.ipv4.conf.all.forwarding = 0
```
• To switch “on” or “off” routing you must edit 
```console
sudo nano /etc/sysctl.conf
# Uncomment the next line to enable packet forwarding for IPv4
net.ipv4.ip_forward=1
```
After editing the file, run the following command to make the changes take effect right away.
```console
sudo sysctl -p

sysctl net.ipv4.conf.all.forwarding
net.ipv4.conf.all.forwarding = 1
```
• To review routing table: 
```console
ip route show
```


#### Server_1
```console
ip a

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:cd:e4:7e brd ff:ff:ff:ff:ff:ff
    inet 192.168.2.30/24 metric 100 brd 192.168.2.255 scope global enp0s3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fecd:e47e/64 scope link
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 08:00:27:e9:21:a2 brd ff:ff:ff:ff:ff:ff
4: enp0s9: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 08:00:27:0f:fc:0e brd ff:ff:ff:ff:ff:ff
```

View the content of Netplan network configuration file Server_1
```console
cat /etc/netplan/*.yaml
    cat /etc/netplan/00-installer-config.yaml

# This is the network config written by 'subiquity'
network:
  ethernets:
    enp0s3:
      dhcp4: true
  version: 2
```

#### Client_1
```console
ip a

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:e2:7a:ce brd ff:ff:ff:ff:ff:ff
    inet 192.168.2.31/24 metric 100 brd 192.168.2.255 scope global enp0s3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fee2:7ace/64 scope link
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 08:00:27:b4:41:7a brd ff:ff:ff:ff:ff:ff
```

View the content of Netplan network configuration file Server_1
```console
cat /etc/netplan/*.yaml
    cat /etc/netplan/00-installer-config.yaml

# This is the network config written by 'subiquity'
network:
  ethernets:
    enp0s3:
      dhcp4: true
  version: 2
```

#### Client_2
```console
ip a

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:95:31:bf brd ff:ff:ff:ff:ff:ff
    inet 192.168.2.32/24 metric 100 brd 192.168.2.255 scope global enp0s3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe95:31bf/64 scope link
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 08:00:27:3e:81:b4 brd ff:ff:ff:ff:ff:ff
```

View the content of Netplan network configuration file Server_1
```console
cat /etc/netplan/*.yaml
    cat /etc/netplan/00-installer-config.yaml

# This is the network config written by 'subiquity'
network:
  ethernets:
    enp0s3:
      dhcp4: true
  version: 2
```

__MODIFY SERVER_1__
```console
https://hackmd.io/@IgorLitvin/HkqwLqeft

sudo nano /etc/netplan/*.yaml

# rename to disable default setting
sudo mv /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.org

# create new
sudo nano /etc/netplan/01-netcfg.yaml

----- V1 ----
network:
  ethernets:
    # interface name
    enp0s3:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [192.168.2.30/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 192.168.2.1
          metric: 100
      #nameservers:
        # name server to bind
        #addresses: [10.0.0.10,10.0.0.11]
        # DNS search base
        #search: [srv.world,server.education]
      #dhcp6: false
  version: 2

----- V2 ----
network:
  version: 2
  renderer: networkd
  ethernets:
    # interface name
    enp0s3:
      dhcp4: false
      optional: true # to any devices that may not always be available. A start job is running without wait for network to be configured.
      # IP address/subnet mask
      addresses: [192.168.2.30/24]
      gateway4: 192.168.2.1
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      #routes:
        #- to: default
          #via: 192.168.2.1
         # metric: 100
      nameservers:
        # name server to bind
        addresses: [192.168.2.1, 8.8.8.8]
        # DNS search base
        #search: [srv.world,server.education]
      #dhcp6: false
    enp0s8:
      dhcp4: false
      optional: true # to any devices that may not always be available. A start job is running without wait for network to be configured.
      # IP address/subnet mask
      addresses: [10.85.8.1/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      #routes:
      #  - to: default
      #    via: 192.168.2.1
         # metric: 100
    enp0s9:
      dhcp4: false
      optional: true # to any devices that may not always be available. A start job is running without wait for network to be configured.
      addresses: [10.3.85.1/24]

# !!! sudo apply changes
sudo netplan generate
sudo netplan apply
sudo systemctl restart systemd-networkd
ip addr 
```

__MODIFY Client_1__
```console
https://hackmd.io/@IgorLitvin/HkqwLqeft

sudo nano /etc/netplan/*.yaml

# rename to disable default setting
sudo mv /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.org

# create new
sudo nano /etc/netplan/01-netcfg.yaml

network:
  version: 2
  renderer: networkd
  ethernets:
    # interface name
    enp0s3:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [192.168.2.31/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 192.168.2.1
         # metric: 100
      nameservers:
        # name server to bind
        addresses: [192.168.2.1, 8.8.8.8]
        # DNS search base
        #search: [srv.world,server.education]
      #dhcp6: false
      
    enp0s8:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [10.85.8.11/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      #routes:
      #  - to: default
      #    via: 192.168.2.1
         # metric: 100

# !!! sudo apply changes
sudo netplan generate
sudo netplan apply
sudo systemctl restart systemd-networkd
ip addr 
```

__MODIFY Client_2__
```console
https://hackmd.io/@IgorLitvin/HkqwLqeft

sudo cat /etc/netplan/*.yaml

# rename to disable default setting
sudo mv /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.org

# create new
sudo nano /etc/netplan/01-netcfg.yaml

network:
  version: 2
  renderer: networkd
  ethernets:
    # interface name
    enp0s3:
      dhcp4: true
      optional: true
    enp0s8:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [10.3.85.11/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      #routes:
      #  - to: default
      #    via: 192.168.2.1
         # metric: 100

# !!! sudo apply changes
sudo netplan generate
sudo netplan apply
sudo systemctl restart systemd-networkd
ip addr 
```

#### Install DHCP Server on Server_1 (Ubuntu 22.04.1 LTS)
https://askubuntu.com/questions/601882/how-to-setup-multi-dhcp-server
https://itnixpro.com/install-dhcp-server-on-ubuntu-22-04/
https://www.server-world.info/en/note?os=Ubuntu_22.04&p=dhcp&f=1

Setup DHCP Server:
```console
sudo apt update

sudo apt install isc-dhcp-server
```
First select Interface card:
```console
sudo nano /etc/default/isc-dhcp-server

INTERFACESv4="enp0s8 enp0s9"
```
Configure Subnet:
```console
sudo nano /etc/dhcp/dhcpd.conf

# option definitions common to all supported networks...
####option domain-name "example.org";
####option domain-name-servers ns1.example.org, ns2.example.org;

####default-lease-time 600;
####max-lease-time 7200;

# The ddns-updates-style parameter controls whether or not the server will
# attempt to do a DNS update when a lease is confirmed. We default to the
# behavior of the version 2 packages ('none', since DHCP v2 didn't
# have support for DDNS.)
####ddns-update-style none;

option domain-name-servers 8.8.8.8, 8.8.8.4;

# Net2 from Server_1(enp0s8) to Client_1 
subnet 10.85.8.0 netmask 255.255.255.0 {
       range 10.85.8.20 10.85.8.200;
        option routers                  10.85.8.1;
        option subnet-mask              255.255.255.0;
        option broadcast-address        10.85.8.255;
        option domain-name-servers      10.85.8.1, 8.8.8.8;
        default-lease-time 86400;
        max-lease-time 86400;
}

# Net2 from Server_1(enp0s9) to Client_2 
subnet  10.3.85.0 netmask 255.255.255.0 {
        range 10.3.85.20 10.3.85.200;
        option routers                  10.3.85.1;
        option subnet-mask              255.255.255.0;
        option broadcast-address        10.3.85.255;
        option domain-name-servers      10.3.85.1, 8.8.8.8;
        default-lease-time 86400;
        max-lease-time 86400;
}
```
--- Open DHCP Server Ports on Firewall --- \
Allow DHCP port on firewall for Server_1, Client_1, Client_2:
```console
sudo ufw allow  67/udp
```
Restart DHCP server to apply changes.
```console
sudo service isc-dhcp-server restart
#OR
sudo systemctl restart isc-dhcp-server.service
```
DHCP server should be up and running, check status using the command below.
```console
sudo systemctl status isc-dhcp-server
```
Restart systemd networkd for Server_1, Client_1, Client_2 and check IP:
```console
sudo systemctl restart systemd-networkd
ip addr 
```
Show active DHCP leases:
```console
dhcp-lease-list

Reading leases from /var/lib/dhcp/dhcpd.leases
MAC                IP              hostname       valid until         manufacturer
===============================================================================================
08:00:27:3e:81:b4  10.3.85.20      client2        2022-11-13 19:57:33 -NA-
08:00:27:b4:41:7a  10.85.8.20      client1        2022-11-13 19:56:53 -NA-
```

#### Ping and Traceroute reluts between :computer: Client_1 :left_right_arrow: Server_1 :left_right_arrow: Client_2 :computer:
Ping commands send multiple requests (usually four or five) and display the results. The echo ping results show whether a particular request received a successful response. It also includes the number of bytes received and the time it took to receive a reply or the time-to-live.

Traceroute works by using the time-to-live (TTL) field in the IP header. Each router that handles an IP packet will decrease the TTL value by one. If the TTL reaches a value of zero, the packet is discarded and a "time exceeded" Type 11 Internet Control Message Protocol (ICMP) message is created to inform the source of the failure. Linux traceroute makes use of the User Datagram Protocol. Windows uses ICMP, and the traceroute command is tracert.
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/Pind_and_Traceroute.png">
</p>


#### Configure NATing and Forwarding on Server_1
https://kifarunix.com/configure-ubuntu-20-04-as-linux-router/ \
NATing and Forwarding can be handled using iptables or via the iptables front-end utility like UFW.
__Configure Packet Forwarding__ \
Configure the packets received from router LAN interfaces (enp0s8 [from Client_1] and enp0s9 [from Client_2]) to be forwarded through the WAN interface, which in our case is enp0s3.
```console
sudo iptables -A FORWARD -i enp0s8 -o enp0s3 -j ACCEPT

sudo iptables -A FORWARD -i enp0s9 -o enp0s3 -j ACCEPT
```
Similarly, configure packets that are associated with existing connections received on a WAN interface to be forwarded to the LAN interfaces;
```console
sudo iptables -A FORWARD -i  enp0s3 -o enp0s8 -m state --state RELATED,ESTABLISHED -j ACCEPT

sudo iptables -A FORWARD -i  enp0s3 -o enp0s9 -m state --state RELATED,ESTABLISHED -j ACCEPT
```
__Configure NATing__ \
Next, configure NATing:
```console
sudo iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
```
:computer: :computer: To ensure that the two local networks [Net2 & Net3] can also communicate, run the commands below:
```console
sudo iptables -t nat -A POSTROUTING -o enp0s8 -j MASQUERADE

sudo iptables -t nat -A POSTROUTING -o enp0s9 -j MASQUERADE

#  !!! Show iptables !!!
sudo iptables -L -nv
# Chain INPUT (policy ACCEPT 678 packets, 280K bytes)
 # pkts bytes target     prot opt in     out     source               destination

# Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 # pkts bytes target     prot opt in     out     source               destination
    # 0     0 ACCEPT     all  --  enp0s8 enp0s3  0.0.0.0/0            0.0.0.0/0
    # 0     0 ACCEPT     all  --  enp0s9 enp0s3  0.0.0.0/0            0.0.0.0/0
    # 0     0 ACCEPT     all  --  enp0s3 enp0s8  0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
    # 0     0 ACCEPT     all  --  enp0s3 enp0s9  0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED

# Chain OUTPUT (policy ACCEPT 453 packets, 51986 bytes)
 # pkts bytes target     prot opt in     out     source               destination


sudo iptables -t filter -L -nv
# Chain INPUT (policy ACCEPT 655 packets, 279K bytes)
 # pkts bytes target     prot opt in     out     source               destination

# Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 # pkts bytes target     prot opt in     out     source               destination
    # 0     0 ACCEPT     all  --  enp0s8 enp0s3  0.0.0.0/0            0.0.0.0/0
    # 0     0 ACCEPT     all  --  enp0s9 enp0s3  0.0.0.0/0            0.0.0.0/0
    # 0     0 ACCEPT     all  --  enp0s3 enp0s8  0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
    # 0     0 ACCEPT     all  --  enp0s3 enp0s9  0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED

# Chain OUTPUT (policy ACCEPT 430 packets, 49802 bytes)
 # pkts bytes target     prot opt in     out     source               destination


sudo iptables -t nat -L -nv
# Chain PREROUTING (policy ACCEPT 51 packets, 4265 bytes)
 # pkts bytes target     prot opt in     out     source               destination

# Chain INPUT (policy ACCEPT 50 packets, 4197 bytes)
 # pkts bytes target     prot opt in     out     source               destination

# Chain OUTPUT (policy ACCEPT 16 packets, 1154 bytes)
 # pkts bytes target     prot opt in     out     source               destination

# Chain POSTROUTING (policy ACCEPT 3 packets, 217 bytes)
 # pkts bytes target     prot opt in     out     source               destination
   # 13   937 MASQUERADE  all  --  *      enp0s3  0.0.0.0/0            0.0.0.0/0
    # 0     0 MASQUERADE  all  --  *      enp0s8  0.0.0.0/0            0.0.0.0/0
    # 0     0 MASQUERADE  all  --  *      enp0s9  0.0.0.0/0            0.0.0.0/0
```
__Save iptables rules Permanently in Linux__ \
In order to permanently save iptables rules, simply install the iptables-persistent package and run the iptables-save command as follows.
```console
sudo apt install iptables-persistent
```
Make sure services are enabled on Debian or Ubuntu using the systemctl command:
```console
sudo systemctl is-enabled netfilter-persistent.service
```
If not enable it:
```console
sudo systemctl enable netfilter-persistent.service
```
Get status:
```console
sudo systemctl status netfilter-persistent.service
```
The current rules will be saved during package installation but can still save them thereafter by running the command:
```console
sudo iptables-save

sudo sh -c "iptables-save > /etc/iptables/rules.v4"
# OR
sudo iptables-save > /etc/iptables/rules.v4
# OR
sudo /sbin/iptables-save > /etc/iptables/rules.v4
```
Now, LAN systems should be now be able to connect to internet via the Server_1.

Displaying saved rules:
```console
cat /etc/iptables/rules.v4

# Generated by iptables-save v1.8.7 on Sun Nov 13 01:51:56 2022
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A FORWARD -i enp0s8 -o enp0s3 -j ACCEPT
-A FORWARD -i enp0s9 -o enp0s3 -j ACCEPT
-A FORWARD -i enp0s3 -o enp0s8 -m state --state RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i enp0s3 -o enp0s9 -m state --state RELATED,ESTABLISHED -j ACCEPT
COMMIT
# Completed on Sun Nov 13 01:51:56 2022
# Generated by iptables-save v1.8.7 on Sun Nov 13 01:51:56 2022
*nat
:PREROUTING ACCEPT [0:0]
:INPUT ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]
-A POSTROUTING -o enp0s3 -j MASQUERADE
-A POSTROUTING -o enp0s8 -j MASQUERADE
-A POSTROUTING -o enp0s9 -j MASQUERADE
COMMIT
# Completed on Sun Nov 13 01:51:56 2022
```
Route Table:
```console
route

Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         _gateway        0.0.0.0         UG    90     0        0 enp0s3
10.3.85.0       0.0.0.0         255.255.255.0   U     0      0        0 enp0s9
10.85.8.0       0.0.0.0         255.255.255.0   U     0      0        0 enp0s8
192.168.2.0     0.0.0.0         255.255.255.0   U     0      0        0 enp0s3
```
Neighbors address resolution:
```console
ip neigh

10.85.8.20 dev enp0s8 lladdr 08:00:27:b4:41:7a STALE
192.168.2.1 dev enp0s3 lladdr 04:8d:38:cd:37:73 STALE
192.168.2.14 dev enp0s3 lladdr a4:1f:72:79:b8:d1 REACHABLE
10.3.85.20 dev enp0s9 lladdr 08:00:27:3e:81:b4 STALE
```

## Answers: 4.
### 4. На віртуальному інтерфейсу lo Client_1 призначити дві ІР адреси за таким правилом: 172.17.D+10.1/24 та 172.17.D+20.1/24. Налаштувати маршрутизацію таким чином, щоб трафік з Client_2 до 172.17.D+10.1 проходив через Server_1, а до 172.17.D+20.1 через Net4. Для перевірки використати traceroute. 

<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/My_Schem%20of%20Linux%20Networking%20(Loopback%20Interface).png">
</p>

Видео:
1. [Настраиваем iptables с нуля](https://www.youtube.com/watch?v=Q0EC8kJlB64&t=757s "Настраиваем iptables с нуля")
2. [IPTables: NAT и Port forwarding](https://www.youtube.com/watch?v=u_a3ouarrVU&t=870s "IPTables: NAT и Port forwarding")
3. [Kirill Semaev. Прокси+firewall. 8 Частей](https://youtu.be/O1SI_ELNoZg "Kirill Semaev. Прокси+firewall. 8 Частей") 


[Netplan configuration examples](https://netplan.io/examples "Netplan configuration examples") 

[Loopback интерфейс: Что это и как его использовать?](http://geek-nose.com/loopback-interfejs/ "Loopback интерфейс: Что это и как его использовать?") 

http://microsin.net/adminstuff/cisco/loopback-null-tunnel-interfaces.html
Loopback - канал коммуникации с одной конечной точкой. Любые сообщения, посылаемые на этот канал, немедленно принимаются тем же самым каналом. Любые сообщения, которые отправляются с этого интерфейса, но у которых адрес не Loopback Interface, отбрасываются. В компьютерах таким адресом loopback interface является адрес 127.0.0.1, он фиксированный и изменению не подлежит. На Unix-like системах loopback interface называется lo или lo0.

На устройствах Cisco Loopback Interface относится к логическим интерфейсам, наряду с Null Interface и Tunnel Interface. Loopback Interface поддерживается на всех устройствах Cisco. Здесь можно создать Loopback Interface с произвольным адресом, это будет чисто программный интерфейс, эмулирующий работу физического. Он может использоваться для удаленного администрирования, и его функционирование не будет зависеть от состояния физических интерфейсов, он будет всегда поднят и доступен для BGP и RSRB сессий.
```console
Router(config)#interface loopback 20
Router(config-if)#ip address 10.10.20.5 255.255.255.254
```
Если нужно обеспечить доступ к Loopback Interface снаружи, то необходимо указать маршрут до подсети, которой принадлежит Loopback Interface.


[Ручная настройка сети в Ubuntu 20 и старше](https://parallel.uran.ru/book/export/html/442 "Ручная настройка сети в Ubuntu 20 и старше") 

В Ubuntu 20 система скриптов ifup/ifdown заменена программой netplan, со своими конфигурационными файлами на языке YAML — /etc/netplan/имяфайла.yaml
Пример конфигурации

Здесь только секция ethernets, но могут быть секции для vlan, bonding и т.д. Массивы имеют две альтернативные формы записи — в квадратных скобках и построчно, где каждая строка начинается с "- ". link-local: [] — запрет IPV6
```console
network:
  version: 2
  renderer: networkd
  ethernets:
    enp3s0f0:
      link-local: []
      addresses:
        - 192.168.56.110/24
      routes:
        - to: 172.16.0.0/24
             via: 192.168.56.100
      gateway4: 192.168.56.1
    nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
```
Команды
netplan generate — генерация из файлов YAML конфигураций для бэкендов NetworkManager или systemd-networkd в каталогах /run/каталог_бэкенда/. Здесь же проходит валидация синтаксиса.

netplan apply — применение конфигурации

__Configuring a loopback interface__ \
Networkd does not allow creating new loopback devices, but a user can add new addresses to the standard loopback interface, lo, in order to have it considered a valid address on the machine as well as for custom routing:

#### Configure Loopback Interface for Client_1 
Net4 – 172.16.D.0/24 or 172.16.8.0/24 \
So, for Client_1 (lo) - 172.17.D+10.1/24 та 172.17.D+20.1/24, \
wiil be next: 172.17.18.1/24, 172.17.28.1/24
```console
# TEST
sudo ip address add 172.17.18.1/24 dev lo
sudo ip address add 172.17.28.1/24 dev lo

# ADD to netplan for Client_1
network:
    version: 2
    renderer: networkd
    ethernets:
        lo:
            addresses: [172.17.18.1/24, 172.17.28.1/24]

```

__MODIFY Client_1__
```console
# sudo nano /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    # interface name
    lo:
      addresses: [172.17.18.1/24, 172.17.28.1/24] # QUESTION 4: ADD loopback interface TO Client_1 (lo: 172.17.18.1/24, 172.17.28.1/24)
    enp0s3:
      dhcp4: true
      optional: true
    enp0s8:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [172.16.8.1/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: 172.16.8.2  # Use Net4 - for connect to  Client_2 IP (172.16.8.2)
          via: 172.16.8.1 # Use Net4 - This Client_1 IP (172.16.8.1)
          metric: 110
        - to: 172.17.28.1 # QUESTION 4: FROM Client_2 (lo: 172.17.28.1/24) through  Net4
          via: 172.16.8.1  # QUESTION 4: and this Client_1 IP (172.16.8.1) from Net4
          metric: 110
    enp0s9: # <-------------------- FOR connect from VBox
      dhcp4:  false
      optional: true
      # IP address/subnet mask
      addresses: [192.168.2.31/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 10.85.8.1
          metric: 120

# !!! sudo apply changes
sudo netplan generate
sudo netplan apply
sudo systemctl restart systemd-networkd
ip addr 
```


__MODIFY SERVER_1__
__Configure Packet Forwarding__
```console
# ADD 2 rules for transfering packets Client_1 <=> Server_1 <=> Client_2  
sudo iptables -A FORWARD -i enp0s8 -o enp0s9 -j ACCEPT
sudo iptables -A FORWARD -i enp0s9 -o enp0s8 -j ACCEPT

#  !!! Show iptables !!!
sudo iptables -L -nv
# Chain INPUT (policy ACCEPT 3145 packets, 437K bytes)
 # pkts bytes target     prot opt in     out     source               destination

# Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 # pkts bytes target     prot opt in     out     source               destination
   # 34  7641 ACCEPT     all  --  enp0s8 enp0s3  0.0.0.0/0            0.0.0.0/0
  # 172 17267 ACCEPT     all  --  enp0s9 enp0s3  0.0.0.0/0            0.0.0.0/0
   # 33 31369 ACCEPT     all  --  enp0s3 enp0s8  0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
  # 214  264K ACCEPT     all  --  enp0s3 enp0s9  0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
  # 293 24684 ACCEPT     all  --  enp0s8 enp0s9  0.0.0.0/0            0.0.0.0/0
  # 421 34356 ACCEPT     all  --  enp0s9 enp0s8  0.0.0.0/0            0.0.0.0/0

# Chain OUTPUT (policy ACCEPT 1880 packets, 191K bytes)
 # pkts bytes target     prot opt in     out     source               destination


sudo iptables -t nat -L -nv
# Chain PREROUTING (policy ACCEPT 425 packets, 35364 bytes)
 # pkts bytes target     prot opt in     out     source               destination

# Chain INPUT (policy ACCEPT 327 packets, 28751 bytes)
 # pkts bytes target     prot opt in     out     source               destination

# Chain OUTPUT (policy ACCEPT 23 packets, 1546 bytes)
 # pkts bytes target     prot opt in     out     source               destination

# Chain POSTROUTING (policy ACCEPT 3 packets, 217 bytes)
 # pkts bytes target     prot opt in     out     source               destination
   # 56  4154 MASQUERADE  all  --  *      enp0s3  0.0.0.0/0            0.0.0.0/0
   # 51  3132 MASQUERADE  all  --  *      enp0s8  0.0.0.0/0            0.0.0.0/0
    # 1    48 MASQUERADE  all  --  *      enp0s9  0.0.0.0/0            0.0.0.0/0

# Save current rules:
sudo iptables-save

sudo sh -c "iptables-save > /etc/iptables/rules.v4"
```

__Configure NETPLAN__
```console
# sudo nano /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    # interface name
    enp0s3:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [192.168.2.30/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 192.168.2.1
          metric: 90
      nameservers:
        # name server to bind
        addresses: [192.168.2.1, 8.8.8.8]
        # DNS search base
        #search: [srv.world,server.education]
      #dhcp6: false
    enp0s8:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [10.85.8.1/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      #routes:
      #  - to: default
      #    via: 192.168.2.1
         # metric: 100
      routes:
        - to: 172.17.18.1 # QUESTION 4: From Client_2 (10.85.8.x) TO Client_1 (lo: 172.17.18.1/24) through Server_1
          via: 10.85.8.1  # QUESTION 4
          metric: 80     # QUESTION 4
    enp0s9:
      dhcp4: false
      optional: true
      addresses: [10.3.85.1/24]
      routes:
        - to: 172.17.18.1 # QUESTION 4: From Client_2 (10.85.8.x) TO Client_1 (lo: 172.17.18.1/24) through Server_1
          via: 10.3.85.1  # QUESTION 4
          metric: 80     # QUESTION 4

# !!! sudo apply changes
sudo netplan generate
sudo netplan apply
sudo systemctl restart systemd-networkd
ip addr 
```

__MODIFY Client_2__
```console
# sudo nano /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    # interface name
    enp0s3:
      dhcp4: true
      optional: true
    enp0s8:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [172.16.8.2/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: 172.16.8.1   # Use Net4 - for connect to  Client_1 IP (172.16.8.1)
          via: 172.16.8.2  # Use Net4 - This Client_2 IP (172.16.8.2)
          metric: 110
        - to: 172.17.28.1  # QUESTION 4: TO Client_1 (lo: 172.17.28.1/24) through  Net4
          via: 172.16.8.2  # QUESTION 4: and this Client_2 IP (172.16.8.2) from Net4
          metric: 110
    enp0s9: # <-------------------- FOR connect from VBox
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [192.168.2.32/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 10.3.85.1
          metric: 120

# !!! sudo apply changes
sudo netplan generate
sudo netplan apply
sudo systemctl restart systemd-networkd
ip addr 
```
#### Check traceroute from Client_2 to Client_1 (172.17.18.1/24 & 172.17.28.1/24):
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/A4_3_My_Schem of Linux Networking (Loopback Interface)_TraceRoute.png">
</p>


## Answers: 5.
### 5. Розрахувати спільну адресу та маску (summarizing) адрес 172.17.D+10.1 та 172.17.D+20.1, при чому префікс має бути максимально можливим. Видалити маршрути, встановлені на попередньому кроці та замінити їх об’єднаним маршрутом, якій має проходити через Server_1.

#### Summarizing:
INFO:
1. [Route Summarization Theory](https://asecuritysite.com/IP/routesum1 "Route Summarization Theory")
2. [Route Summarization Calc](https://asecuritysite.com/IP/routesum "Route Summarization Calc")
3. [jodies.de/ipcalc](https://jodies.de/ipcalc "jodies.de/ipcalc")

```console
So, 172.17.18.1-172.17.28.1 (172.17.18.1-172.17.28.255) gives: 

10101100.00010001 .0001 0010.00000000 = 172.17.18.1
10101100.00010001 .0001 1100.00000001 = 172.17.28.1
10101100.00010001 .0001 1100.11111111 = 172.17.28.255

where the common part is: 10101100.00010001 .0001
where 10101100 is 172, 
where 00010001 is 17, 
where 0001xxxx is 16, 
which gives: 172.17.16.0 and since we using 20 bits (8+8+4) to give a route summarization of: 172.17.16.0/20 
```

| 172.17.16.0/20     |        Dec       |                 Bin                   |
| ------------------ |:----------------:| ------------------------------------- |
| Address:           | 172.17.16.0      |  10101100.00010001.0001 0000.00000000 |
| Netmask:           | 255.255.240.0/20 |  11111111.11111111.1111 0000.00000000 |
| Network (Class B): | 172.17.16.0/20   |  10101100.00010001.0001 0000.00000000 |
| Broadcast:         | 172.17.31.255    |  10101100.00010001.0001 1111.11111111 |
| Host Min:          | 172.17.16.1      |  10101100.00010001.0001 0000.00000001 |
| Host Max:          | 172.17.31.254    |  10101100.00010001.0001 1111.11111110 |
| Hosts:             | 4094             | 


Supernet Address: 172.17.16.0/20 \
Supernet Range:172.17.16.0 - 172.17.31.255 \
Total IPs: 4 096 \
Subnet/Network Mask: 255.255.240.0 \
Wildcard/Host Mask: 0.0.15.255

10101100.00010000.00000000.00000000 (172.16.0.0) \
10101100.00011111.11111111.11111111 (172.31.255.255)

#### Configuring Packet Forwarding through Server_1 for loopback interface Client_1 with Host Max IP 172.17.31.254/20:
| 172.17.16.0/20     |        Dec       |
| ------------------ |:----------------:|
| Host Max:          | 172.17.31.254    |

#### Check traceroute from Client_2 to Client_1 (loopback interface: 172.17.31.254/20) through Server_1:
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/A5_My_Schem of Linux Networking (Loopback Interface_Q5)_TraceRoute.png">
</p>


__MODIFY Client_1__
```console
sudo nano /etc/netplan/01-netcfg.yaml

#Client_1
network:
  version: 2
  renderer: networkd
  ethernets:
    # interface name
    lo:
      addresses: [172.17.31.254/20] # QUESTION 5: Conf loopback interface for summarizing on  Client_1
    enp0s3:
      dhcp4: true
      optional: true
    enp0s8:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [172.16.8.1/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: 172.16.8.2  # Use Net4 - for connect to  Client_2 IP (172.16.8.2)
          via: 172.16.8.1 # Use Net4 - This Client_1 IP (172.16.8.1)
          metric: 110
    enp0s9: # <-------------------- FOR connect from VBox
      dhcp4:  false
      optional: true
      # IP address/subnet mask
      addresses: [192.168.2.31/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 10.85.8.1
          metric: 120

# !!! sudo apply changes
sudo netplan generate
sudo netplan apply
sudo systemctl restart systemd-networkd
ip addr 
```


__MODIFY Server_1__
```console
sudo nano /etc/netplan/01-netcfg.yaml

#Server_1
network:
  version: 2
  renderer: networkd
  ethernets:
    # interface name
    enp0s3:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [192.168.2.30/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 192.168.2.1
          metric: 90
      nameservers:
        # name server to bind
        addresses: [192.168.2.1, 8.8.8.8]
        # DNS search base
        #search: [srv.world,server.education]
      #dhcp6: false
    enp0s8:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [10.85.8.1/24]
      routes:
        - to: 172.17.31.254 # QUESTION 5: From Client_2 (10.85.8.x) TO Client_1 (lo: 172.17.31.254/20) through Server_1
          via: 10.85.8.1  # QUESTION 5
          metric: 80     # QUESTION 5
    enp0s9:
      dhcp4: false
      optional: true
      addresses: [10.3.85.1/24]
      routes:
        - to: 172.17.31.254 # QUESTION 5: From Client_2 (10.85.8.x) TO Client_1 (lo: 172.17.31.254/20) through Server_1
          via: 10.3.85.1  # QUESTION 5
          metric: 80     # QUESTION 5

# !!! sudo apply changes
sudo netplan generate
sudo netplan apply
sudo systemctl restart systemd-networkd
ip addr 
```


__MODIFY Client_2__
```console
sudo nano /etc/netplan/01-netcfg.yaml

#Client_2
network:
  version: 2
  renderer: networkd
  ethernets:
    # interface name
    enp0s3:
      dhcp4: true
      optional: true
    enp0s8:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [172.16.8.2/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: 172.16.8.1   # Use Net4 - for connect to  Client_1 IP (172.16.8.1)
          via: 172.16.8.2  # Use Net4 - This Client_2 IP (172.16.8.2)
          metric: 110
    enp0s9: # <-------------------- FOR connect from VBox
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [192.168.2.32/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 10.3.85.1
          metric: 120
# !!! sudo apply changes
sudo netplan generate
sudo netplan apply
sudo systemctl restart systemd-networkd
ip addr 
```
## Answers: 6.
### 6. Налаштувати SSH сервіс таким чином, щоб Client_1 та Client_2 могли підключатись до Server_1 та один до одного.  

__INFO__:
1. [How to Set Up SSH Keys on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04 "How to Set Up SSH Keys on Ubuntu 20.04")
2. [How To Install and Enable SSH Server on Ubuntu 20.04](https://devconnected.com/how-to-install-and-enable-ssh-server-on-ubuntu-20-04/ "How To Install and Enable SSH Server on Ubuntu 20.04")
3. [How to Install and Enable OpenSSH on Ubuntu 22.04](https://linuxhint.com/install-enable-openssh-ubuntu-22-04/ "How to Install and Enable OpenSSH on Ubuntu 22.04")
4. [How to Use ssh-keygen to Generate an SSH Key](https://linuxhint.com/use-ssh-keygen-to-generate-an-ssh-key/ "How to Use ssh-keygen to Generate an SSH Key")
5. [How do I add new user accounts with SSH access to my Amazon EC2 Linux instance?](https://aws.amazon.com/ru/premiumsupport/knowledge-center/new-user-accounts-linux-instance/ "How do I add new user accounts with SSH access to my Amazon EC2 Linux instance?")
6. [SSH Public Key Based Authentication on a Linux/Unix server](https://www.cyberciti.biz/tips/ssh-public-key-based-authentication-how-to.html "SSH Public Key Based Authentication on a Linux/Unix server")
7. [How to Show All Active SSH Connections in Linux](https://www.maketecheasier.com/show-active-ssh-connections-linux/ "How to Show All Active SSH Connections in Linux")

__MODIFY Client_1__
```console
# !!! Install OpenSSH Server !!!
# System Update
sudo apt update && sudo apt upgrade

# Install OpenSSH
sudo apt install openssh-server

# Enable OpenSSH
sudo systemctl enable --now ssh

# Evaluate OpenSSH Status
sudo systemctl status ssh

# The Ubuntu systems ships with default UFW firewall, If the UFW is active, you need to allow SSH port 22 for remote users. To allow port 22 in UFW type:
sudo ufw allow 22/tcp 

# Connect to SSH Server
ssh username@ip-address/hostname

# !!! Disabling OpenSSH !!!
# The systems with physical access are less required SSH access. In that case, you can either block ssh access using the firewall or disable the SSH service on your system.

# To block SSH access via UFW firewall, type:
sudo ufw deny 22/tcp 

# You can also completely disable the SSH service (OpenSSH) to prevent remote access.
sudo systemctl stop --now ssh 
sudo systemctl disable --now ssh 


# !!! Add new user with password !!!: 
sudo useradd -m -d /home/ssh_user_4client1 -s /bin/bash ssh_user_4client1
sudo passwd ssh_user_4client1

# Change user:
su ssh_user_4client1
cd ~

# Create a .ssh directory in the new_user home directory:
mkdir /home/ssh_user_4client1/.ssh

# ensure the directory ir owned by the new user
# chown -R username:username /home/username/.ssh
chown -R ssh_user_4client1:ssh_user_4client1 /home/ssh_user_4client1/.ssh

# Use the chmod command to change the .ssh directory's permissions to 700. Changing the permissions restricts access so that only the new_user can read, write, or open the .ssh directory.
# chmod 700 /home/username/.ssh
chmod 700 /home/ssh_user_4client1/.ssh

# Use the touch command to create the authorized_keys file in the .ssh directory:
# touch /home/username/.ssh/authorized_keys
touch /home/ssh_user_4client1/.ssh/authorized_keys

# Use the chmod command to change the .ssh/authorized_keys file permissions to 600. Changing the file permissions restricts read or write access to the new_user.
# chmod 600 /home/username/.ssh/authorized_keys
chmod 600 /home/ssh_user_4client1/.ssh/authorized_keys


# Last, if you want the new user to have sudo access, be sure to add them to the sudo group:
sudo usermod -a -G sudo username

# If you don’t have a sudo group, you can manually edit the 
/etc/sudoers file.
```
```console
# !!! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! !!!:
# !!! To display all users run following command !!!:
# !!! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! !!!:
compgen -u

To display all groups run following command:
compgen -g

# However you can also display all users by 
cut -d ":" -f 1 /etc/passwd.
```

__!!! Then create ssh_user_4client1 on Client_2 server. !!!__s

Connect from Client_1 to Client_2 (10.3.85.21) with ssh_user_4client1 using SSH Public Key Based Authentication:
```console
# Create the cryptographic keys on Client_1
ssh_user_4client1@client1:~$ ssh-keygen -t rsa
# Generating public/private rsa key pair.
Enter file in which to save the key (/home/ssh_user_4client1/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
# Your identification has been saved in /home/ssh_user_4client1/.ssh/id_rsa
# Your public key has been saved in /home/ssh_user_4client1/.ssh/id_rsa.pub
# The key fingerprint is:
# SHA256:+Mm94lDdE8ygQDDYHHGTB3fpqOyyZ/JuZd+rDYiCQiw ssh_user_4client1@client1
# The key's randomart image is:
+---[RSA 3072]----+
|   +==*o. o.     |
|  . oo.+.o.+     |
|       ..o  +    |
|.      ..... .   |
|Eo   ...S . o    |
|o  .  o=o+   .   |
|. . ..oo=.o.     |
| .  o.=.. .+.    |
|    .Xo...o.o.   |
+----[SHA256]-----+

# Use the scp command to copy the id_rsa.pub (public key) from Client_1 to Client_2 as authorized_keys file, this is know as, “installing the public key to server”:
scp ~/.ssh/id_rsa.pub vivek@rh9linux.nixcraft.org:~/.ssh/authorized_keys

# Another option is to use the ssh-copy-id command as follows from Client_1:
ssh-copy-id ssh_user_4client1@10.3.85.21
# OR
ssh-copy-id -i ~/.ssh/id_rsa.pub ssh_user_4client1@10.3.85.21

ssh_user_4client1@client1:~$ ssh-copy-id ssh_user_4client1@10.3.85.21
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/ssh_user_4client1/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
ssh_user_4client1@10.3.85.21's password:

# Number of key(s) added: 1

# Now try logging into the machine, with:   "ssh 'ssh_user_4client1@10.3.85.21'"
and check to make sure that only the key(s) you wanted were added.

ssh_user_4client1@client1:~$ ssh ssh_user_4client1@10.3.85.21
Enter passphrase for key '/home/ssh_user_4client1/.ssh/id_rsa':

# Welcome to Ubuntu 22.04.1 LTS (GNU/Linux 5.15.0-53-generic x86_64)

ssh_user_4client1@client2:~$ hostname && hostname -I
client2
10.3.85.21 172.16.8.2 192.168.2.32
```

__MODIFY Client_2__ \
!!! Create ssh_user_4client2 on Client_2 server. !!! \
!!! Create ssh_user_4client2 on Client_1 server. !!!
```console
sudo useradd -m -d /home/ssh_user_4client2 -s /bin/bash ssh_user_4client2
sudo passwd ssh_user_4client2

# Change user:
su ssh_user_4client2
cd ~
```
Connect directly from Client_2 to Client_1 (10.85.8.21) with ssh_user_4client2:
```console
ssh ssh_user_4client2@10.85.8.21
ssh_user_4client2@client2:~$ ssh ssh_user_4client2@10.85.8.21

The authenticity of host '10.85.8.21 (10.85.8.21)' can't be established.
ED25519 key fingerprint is SHA256:NPz1sLLW8+oY6KOczKqeUhuB3DSFz8TZKnm9E9O0TOg.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? 
yes
Warning: Permanently added '10.85.8.21' (ED25519) to the list of known hosts.

ssh_user_4client2@10.85.8.21's password:

# Welcome to Ubuntu 22.04.1 LTS (GNU/Linux 5.15.0-52-generic x86_64)

ssh_user_4client2@client1:~$ hostname && hostname -I
client1
10.85.8.21 172.16.8.1 192.168.2.31
```
__MODIFY Server_1__ \
!!! Create ssh_user_4client2 on Client_2 server. !!! \
!!! Create ssh_user_4client2 on Client_1 server. !!!
```console
sudo useradd -m -d /home/ssh_user_4client1 -s /bin/bash ssh_user_4client1
sudo passwd ssh_user_4client1
```

Connect directly from Client_1 (10.85.8.21) to Server_1 (10.85.8.1) with ssh_user_4client1:
```console
ubuntu@client1:$ ssh ssh_user_4client1@10.85.8.1

The authenticity of host '10.85.8.1 (10.85.8.1)' can't be established.
ED25519 key fingerprint is SHA256:NPz1sLLW8+oY6KOczKqeUhuB3DSFz8TZKnm9E9O0TOg.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? 
yes

Warning: Permanently added '10.85.8.1' (ED25519) to the list of known hosts.
ssh_user_4client1@10.85.8.1's password:

# Welcome to Ubuntu 22.04.1 LTS (GNU/Linux 5.15.0-52-generic x86_64)

ssh_user_4client1@server1:~$ hostname && hostname -I
server1
192.168.2.30 10.85.8.1 10.3.85.1
```

Connect directly from Client_2 (10.3.85.21) to Server_1 (10.3.85.1) with ssh_user_4client1:
```console
ubuntu@client2:~$ ssh ssh_user_4client2@10.3.85.1

The authenticity of host '10.3.85.1 (10.3.85.1)' can't be established.
ED25519 key fingerprint is SHA256:NPz1sLLW8+oY6KOczKqeUhuB3DSFz8TZKnm9E9O0TOg.
This host key is known by the following other names/addresses:
    ~/.ssh/known_hosts:1: [hashed name]
Are you sure you want to continue connecting (yes/no/[fingerprint])? 
yes

Warning: Permanently added '10.3.85.1' (ED25519) to the list of known hosts.
ssh_user_4client2@10.3.85.1's password:

# Welcome to Ubuntu 22.04.1 LTS (GNU/Linux 5.15.0-52-generic x86_64)

ssh_user_4client2@server1:~$ hostname && hostname -I
server1
192.168.2.30 10.85.8.1 10.3.85.1
```
__Show All Active SSH Connections__
```console
ubuntu@server1:~$ who
ubuntu   pts/0        2022-11-18 17:46 (192.168.2.14)
ssh_user_4client1 pts/1        2022-11-18 17:50 (10.85.8.21)
ssh_user_4client2 pts/2        2022-11-18 17:55 (10.3.85.21)


ubuntu@server1:~$ w
 18:01:13 up  2:47,  3 users,  load average: 0.00, 0.00, 0.00
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
ubuntu   pts/0    192.168.2.14     17:46    1.00s  0.03s  0.00s w
ssh_user pts/1    10.85.8.21       17:50    9:21   0.01s  0.01s -bash
ssh_user pts/2    10.3.85.21       17:55   47.00s  0.02s  0.02s -bash


ubuntu@server1:~$ last
ssh_user pts/2        10.3.85.21       Fri Nov 18 17:55   still logged in
ssh_user pts/1        10.85.8.21       Fri Nov 18 17:50   still logged in
ubuntu   pts/0        192.168.2.14     Fri Nov 18 17:46   still logged in
reboot   system boot  5.15.0-52-generi Fri Nov 18 15:14   still running
ubuntu   pts/0        192.168.2.14     Thu Nov 17 21:28 - 22:13  (00:44)
reboot   system boot  5.15.0-52-generi Thu Nov 17 20:57 - 22:13  (01:15)
ubuntu   pts/0        192.168.2.14     Thu Nov 17 00:16 - 01:07  (00:51)
...


ubuntu@server1:~$ last | grep still
ssh_user pts/2        10.3.85.21       Fri Nov 18 17:55   still logged in
ssh_user pts/1        10.85.8.21       Fri Nov 18 17:50   still logged in
ubuntu   pts/0        192.168.2.14     Fri Nov 18 17:46   still logged in
reboot   system boot  5.15.0-52-generi Fri Nov 18 15:14   still running


ubuntu@server1:~$ last -w
ssh_user_4client2 pts/2        10.3.85.21       Fri Nov 18 17:55   still logged in
ssh_user_4client1 pts/1        10.85.8.21       Fri Nov 18 17:50   still logged in
ubuntu   pts/0        192.168.2.14     Fri Nov 18 17:46   still logged in
reboot   system boot  5.15.0-52-generic Fri Nov 18 15:14   still running
ubuntu   pts/0        192.168.2.14     Thu Nov 17 21:28 - 22:13  (00:44)
...


ubuntu@server1:~$ netstat | grep ssh
tcp        0     64 server1:ssh             192.168.2.14:53785      ESTABLISHED
tcp        0      0 server1:ssh             10.3.85.21:59476        ESTABLISHED
tcp        0      0 server1:ssh             10.85.8.21:59250        ESTABLISHED
tcp        0      0 server1:ssh             192.168.2.14:53786      ESTABLISHED



ubuntu@server1:~$ ss -a | grep ssh
u_str LISTEN 0      4096         /run/user/1002/gnupg/S.gpg-agent.ssh 24410                          * 0
u_str LISTEN 0      4096         /run/user/1001/gnupg/S.gpg-agent.ssh 24058                          * 0
u_str LISTEN 0      4096         /run/user/1000/gnupg/S.gpg-agent.ssh 22665                          * 0
tcp   LISTEN 0      128                                       0.0.0.0:ssh                      0.0.0.0:*
tcp   ESTAB  0      0                                    192.168.2.30:ssh                 192.168.2.14:53785
tcp   ESTAB  0      0                                       10.3.85.1:ssh                   10.3.85.21:59476
tcp   ESTAB  0      0                                       10.85.8.1:ssh                   10.85.8.21:59250
tcp   ESTAB  0      0                                    192.168.2.30:ssh                 192.168.2.14:53786
tcp   LISTEN 0      128                                          [::]:ssh                         [::]:*


ubuntu@server1:~$ ss -a | grep ssh | grep ESTAB
tcp   ESTAB  0      64                                   192.168.2.30:ssh                 192.168.2.14:53785
tcp   ESTAB  0      0                                       10.3.85.1:ssh                   10.3.85.21:59476
tcp   ESTAB  0      0                                       10.85.8.1:ssh                   10.85.8.21:59250
tcp   ESTAB  0      0                                    192.168.2.30:ssh                 192.168.2.14:53786
```

## Answers: 7.
### 7. Налаштуйте на Server_1 firewall таким чином:
### - Дозволено підключатись через SSH з Client_1 та заборонено з Client_2 
### - З Client_2 на 172.17.D+10.1 ping проходив, а на 172.17.D+20.1 не проходив 

__INFO__:
1. [Step 4 — Setting Up a Basic Firewall](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-20-04 "Step 4 — Setting Up a Basic Firewall")
2. [How to open ssh 22/TCP port using ufw on Ubuntu/Debian Linux](https://www.cyberciti.biz/faq/ufw-allow-incoming-ssh-connections-from-a-specific-ip-address-subnet-on-ubuntu-debian/ "How to open ssh 22/TCP port using ufw on Ubuntu/Debian Linux")
3. [How to block an IP address with ufw on Ubuntu Linux server](https://www.cyberciti.biz/faq/how-to-block-an-ip-address-with-ufw-on-ubuntu-linux-server/ "How to block an IP address with ufw on Ubuntu Linux server")
[How To Configure Firewall with UFW on Ubuntu 20.04 LTS](https://www.cyberciti.biz/faq/how-to-configure-firewall-with-ufw-on-ubuntu-20-04-lts/ "How To Configure Firewall with UFW on Ubuntu 20.04 LTS")


#### - Дозволено підключатись через SSH з Client_1 та заборонено з Client_2

Client_1 (10.85.8.x) 
Client_2 (10.3.85.x) 
Server_1 (10.85.8.1, 10.3.85.1)

Applications can register their profiles with UFW upon installation. These profiles allow UFW to manage these applications by name. OpenSSH, the service allowing us to connect to our server now, has a profile registered with UFW.

```console
# Check OpenSSH, the service has a profile registered with UFW:
ubuntu@server1:~$ sudo ufw app list
  Available applications:
    OpenSSH

# Make sure that the firewall allows SSH connections:
ubuntu@server1:~$ sudo ufw allow OpenSSH
  Rules updated
  Rules updated (v6)

# Enable the firewall by typing:
ubuntu@server1:~$ sudo ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? 
  y
Firewall is active and enabled on system startup

# Check that SSH connections are still allowed:
ubuntu@server1:~$ sudo ufw status
Status: active

    To                         Action      From
    --                         ------      ----
    67/udp                     ALLOW       Anywhere
    OpenSSH                    ALLOW       Anywhere
    67/udp (v6)                ALLOW       Anywhere (v6)
    OpenSSH (v6)               ALLOW       Anywhere (v6)


# !!! UFW block subnet (CIDR) !!!
# Server_1 interface IP 10.3.85.1 for Client_2, so
sudo ufw deny proto tcp from 10.3.85.1/24 to any port 22

ubuntu@server1:~$ sudo ufw deny proto tcp from 10.3.85.1/24 to any port 22
  [sudo] password for ubuntu:
  WARN: Rule changed after normalization
  Rule added

ubuntu@server1:~$ sudo ufw status
  Status: active

  To                         Action      From
  --                         ------      ----
  67/udp                     ALLOW       Anywhere
  OpenSSH                    ALLOW       Anywhere
  22/tcp                     DENY        10.3.85.0/24
  67/udp (v6)                ALLOW       Anywhere (v6)
  OpenSSH (v6)               ALLOW       Anywhere (v6)

ubuntu@server1:~$ sudo ufw status numbered
  Status: active

      To                         Action      From
      --                         ------      ----
  [ 1] 67/udp                     ALLOW IN    Anywhere
  [ 2] OpenSSH                    ALLOW IN    Anywhere
  [ 3] 22/tcp                     DENY IN     10.3.85.0/24
  [ 4] 67/udp (v6)                ALLOW IN    Anywhere (v6)
  [ 5] OpenSSH (v6)               ALLOW IN    Anywhere (v6)


# !!! Tip: UFW NOT blocking an IP address !!! 

# UFW (iptables) rules are applied in order of appearance, and the inspection ends immediately when there is a match. Therefore, for example, if a rule is allowing access to tcp port 22 (say using sudo ufw allow 22), and afterward another Rule is specified blocking an IP address (say using ufw deny proto tcp from 10.3.85.1 to any port 22), the rule to access port 22 is applied and the later rule to block the hacker IP address 10.3.85.1 is not. It is all about the order. To avoid such problem you need to edit the /etc/ufw/before.rules file and add a section to “Block an IP Address” after “# End required lines” section.

ubuntu@server1:~$ sudo nano /etc/ufw/before.rules
...
# End required lines

# Block ip/net (subnet)
-A ufw-before-input -s 10.3.85.0/24 -j DROP
...

ubuntu@server1:~$ sudo ufw reload
  Firewall reloaded

```
#### Show All Active SSH Connections (for example on Server_1)
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/A7_UFW_block_subnet_(CIDR).png">
</p>


#### - З Client_2 на 172.17.D+10.1 ping проходив, а на 172.17.D+20.1 не проходив 

__MODIFY Client_1__
```console
sudo nano /etc/netplan/01-netcfg.yaml

#Client_1
network:
  version: 2
  renderer: networkd
  ethernets:
    # interface name
    lo:
      addresses: [172.17.18.1/20, 172.17.28.1/20, 172.17.31.254/20] # QUESTION 7
    enp0s3:
      dhcp4: true
      optional: true
    enp0s8:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [172.16.8.1/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: 172.16.8.2  # Use Net4 - for connect to  Client_2 IP (172.16.8.2)
          via: 172.16.8.1 # Use Net4 - This Client_1 IP (172.16.8.1)
          metric: 110
    enp0s9: # <-------------------- FOR connect from VBox
      dhcp4:  false
      optional: true
      # IP address/subnet mask
      addresses: [192.168.2.31/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 10.85.8.1
          metric: 120

# !!! sudo apply changes
sudo netplan generate
sudo netplan apply
sudo systemctl restart systemd-networkd
ip addr 
```


__MODIFY Server_1__
```console
sudo nano /etc/netplan/01-netcfg.yaml

#Server_1
network:
  version: 2
  renderer: networkd
  ethernets:
    # interface name
    enp0s3:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [192.168.2.30/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 192.168.2.1
          metric: 90
      nameservers:
        # name server to bind
        addresses: [192.168.2.1, 8.8.8.8]
        # DNS search base
        #search: [srv.world,server.education]
      #dhcp6: false
    enp0s8:
      dhcp4: false
      optional: true
      # IP address/subnet mask
      addresses: [10.85.8.1/24]
      routes:
        - to: 172.17.18.1 # QUESTION 7
          via: 10.85.8.1  # QUESTION 7
          metric: 70      # QUESTION 7
        - to: 172.17.28.1 # QUESTION 7
          via: 10.85.8.1  # QUESTION 7
          metric: 71     # QUESTION 7
        - to: 172.17.31.254 # QUESTION 7
          via: 10.85.8.1  # QUESTION 7
          metric: 72     # QUESTION 7
    enp0s9:
      dhcp4: false
      optional: true
      addresses: [10.3.85.1/24]
      routes:
        - to: 172.17.18.1 # QUESTION 7: From Client_2 (10.85.8.x) TO Client_1 (lo: 172.17.18.1/20) through Server_1
          via: 10.3.85.1  # QUESTION 7
          metric: 80     # QUESTION 7
        - to: 172.17.28.1 # QUESTION 7: From Client_2 (10.85.8.x) TO Client_1 (lo: 172.17.28.1/20) through Server_1
          via: 10.3.85.1  # QUESTION 7
          metric: 81     # QUESTION 7
        - to: 172.17.31.254 # QUESTION 7: From Client_2 (10.85.8.x) TO Client_1 (lo: 172.17.31.254/20) through Server_1
          via: 10.3.85.1  # QUESTION 7
          metric: 82     # QUESTION 7

# !!! sudo apply changes
sudo netplan generate
sudo netplan apply
sudo systemctl restart systemd-networkd
ip addr 
```

__MODIFY Client_2__
```console

!!! Didn't need to modify !!!

```

Client_2 (10.3.85.x) :arrow_right: [trought Server_1] :arrow_right: Client_1 (10.85.8.x): \
:arrow_right: 172.17.18.1 - ALLOW \
:arrow_right: 172.17.28.1 - DENY

__MODIFY Client_1__
```console

# Check OpenSSH, the service has a profile registered with UFW:
ubuntu@server1:~$ sudo ufw app list
  Available applications:
    OpenSSH

# Make sure that the firewall allows SSH connections:
ubuntu@server1:~$ sudo ufw allow OpenSSH
  Rules updated
  Rules updated (v6)

# Enable the firewall by typing:
ubuntu@server1:~$ sudo ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? 
  y
Firewall is active and enabled on system startup

# Check that SSH connections are still allowed:
ubuntu@server1:~$ sudo ufw status
Status: active

    To                         Action      From
    --                         ------      ----
    67/udp                     ALLOW       Anywhere
    OpenSSH                    ALLOW       Anywhere
    67/udp (v6)                ALLOW       Anywhere (v6)
    OpenSSH (v6)               ALLOW       Anywhere (v6)

# !!! Tip: UFW NOT blocking an IP address !!! 

# UFW (iptables) rules are applied in order of appearance, and the inspection ends immediately when there is a match. Therefore, for example, if a rule is allowing access to tcp port 22 (say using sudo ufw allow 22), and afterward another Rule is specified blocking an IP address (say using ufw deny proto tcp from 10.3.85.1 to any port 22), the rule to access port 22 is applied and the later rule to block the hacker IP address 10.3.85.1 is not. It is all about the order. To avoid such problem you need to edit the /etc/ufw/before.rules file and add a section to “Block an IP Address” after “# End required lines” section.

ubuntu@server1:~$ sudo nano /etc/ufw/before.rules
...
# End required lines

# Drop icmp to specific IP
-A ufw-before-input -p icmp --icmp-type echo-request -d 172.17.28.1 -j REJECT
...

ubuntu@server1:~$ sudo ufw reload
  Firewall reloaded


ubuntu@client1:~$ sudo ufw status numbered
Status: active

     To                         Action      From
     --                         ------      ----
[ 1] 67/udp                     ALLOW IN    Anywhere
[ 2] OpenSSH                    ALLOW IN    Anywhere
[ 3] 67/udp (v6)                ALLOW IN    Anywhere (v6)
[ 4] OpenSSH (v6)               ALLOW IN    Anywhere (v6)


ubuntu@client1:~$ sudo iptables -L -nv

Chain ufw-before-input (1 references)
 pkts bytes target     prot opt in     out     source               destination
    7   588 REJECT     icmp --  *      *       0.0.0.0/0            172.17.28.1          icmptype 8 reject-with icmp-port-unreachable
   38  4054 ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0
  670 59144 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate RELATED,ESTABLISHED
    0     0 ufw-logging-deny  all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate INVALID
    0     0 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate INVALID
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0            icmptype 3
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0            icmptype 11
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0            icmptype 12
    2   168 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0            icmptype 8
    0     0 ACCEPT     udp  --  *      *       0.0.0.0/0            0.0.0.0/0            udp spt:67 dpt:68
  158  7387 ufw-not-local  all  --  *      *       0.0.0.0/0            0.0.0.0/0
    0     0 ACCEPT     udp  --  *      *       0.0.0.0/0            224.0.0.251          udp dpt:5353
    0     0 ACCEPT     udp  --  *      *       0.0.0.0/0            239.255.255.250      udp dpt:1900
  158  7387 ufw-user-input  all  --  *      *       0.0.0.0/0            0.0.0.0/0

```
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/A7_UFW_block_PING2LO.png">
</p>



## Answers: 8.
### 8. Якщо в п.3 була налаштована маршрутизація для доступу Client_1 та Client_2 до мережі Інтернет – видалити відповідні записи. На Server_1 налаштувати NAT сервіс таким чином, щоб з Client_1 та Client_2 проходив ping в мережу Інтернет.



!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

__Команда IP в Linux: руководство с примерами__ \
https://wiki.merionet.ru/servernye-resheniya/46/komanda-ip-v-linux-rukovodstvo-s-primerami/ \
__Руководство администратора Linux по устранению неполадок и отладке__ \
https://wiki.merionet.ru/servernye-resheniya/18/rukovodstvo-administratora-linux-po-ustraneniyu-nepoladok-i-otladke/ \
__Погружение в Iptables – теория и настройка__ \
https://wiki.merionet.ru/servernye-resheniya/14/pogruzhenie-v-iptables-teoriya-i-nastrojka/
```console
# просмотр списка доступных интерфейсов
ip link

# просмотр статистики по интерфейсам
ip -s link

# просмотр ip адресов 
ip addr
ip -4 addr # отобразить только IPv4

# просмотр таблицы маршрутизации
ip route

# !!! Изменить статус сетевого интерфейса !!!
# Если вы хотите включить сетевой интерфейс, используйте команду:
ip link set [interface] up

# Отключите интерфейс, введя:
ip link set [interface] down

# Команда ip link позволяет вам изменять очередь передачи, ускоряя или замедляя интерфейсы в соответствии с вашими потребностями и аппаратными возможностями.
ip link set txqueuelen [number] dev [interface]

# Вы можете установить MTU (Maximum Transmission Unit) для улучшения производительности сети:
ip link set mtu [number] dev [interface]

# !!! Как добавить IP-адрес в Linux !!!

# Добавьте IP-адрес в интерфейс с помощью команды:
ip addr add [ip_address] dev [interface]

# Если указанный интерфейс не существует, отобразится сообщение: Cannot find device [interface]
# Чтобы добавить два адреса на один интерфейс также используйте эту команду:
ip address add 192.168.1.41/24 dev eth0
ip address add 192.168.1.40/24 dev eth0

# Если вам нужно добавить широковещательный (broadcast) адрес для интерфейса, используйте команду:
ip addr add brd [ip_address] dev [interface]

# Чтобы удалить IP-адрес из интерфейса, выполните следующие действия.
ip addr del [ip_address] dev [interface]

# Чтобы показать текущую таблицу соседей в ядре, введите:
ip neigh


# MTR - это современный инструмент для диагностики сети из командной строки, который объединяет функции ping и traceroute в одном диагностическом инструменте. Его вывод обновляется в режиме реального времени, по умолчанию, пока вы не выйдете из программы, нажав q.
# Самый простой способ запустить mtr - указать в качестве аргумента имя хоста или IP-адрес следующим образом:
mtr google.com

# route - это утилита для отображения или манипулирования таблицей IP-маршрутизации системы Linux. Route в основном используется для настройки статических маршрутов к конкретным хостам или сетям через интерфейс.
# Вы можете просмотреть таблицу маршрутизации IP ядра, набрав:
route

# Nmcli - это простой в использовании инструмент с поддержкой сценариев, позволяющий сообщать о состоянии сети, управлять сетевыми подключениями и управлять NetworkManager.
# Чтобы просмотреть все ваши сетевые устройства, введите:
nmcli dev status
# Чтобы проверить сетевые подключения в вашей системе, введите:
nmcli con show
# Чтобы увидеть только активные соединения, добавьте флаг -a.
nmcli con show -a

# ss (socket statistics - статистика сокетов) - мощная утилита командной строки для изучения сокетов. Он выводит статистику сокетов и отображает информацию, аналогичную netstat. Кроме того, ss показывает больше информации о TCP и состоянии по сравнению с другими подобными утилитами.
# В следующем примере показано, как составить список всех TCP-портов (сокетов), открытых на сервере.
ss -ta
# Чтобы отобразить все активные TCP-соединения вместе с их таймерами, выполните следующую команду.
ss -to

# Nmap (Network Mapper) - это мощный и чрезвычайно универсальный инструмент для системных и сетевых администраторов Linux. Он используется для сбора информации об одном хосте или для изучения сетей по всей сети. Nmap также используется для сканирования безопасности, аудита сети, поиска открытых портов на удаленных хостах и многого другого.
# Например, вы можете сканировать хост, используя его имя или IP-адрес.
nmap google.com
nmap 192.168.0.103

# Команда hos - это простая утилита для DNS Lookup, она переводит имена хостов в IP-адреса и наоборот.
host google.com

# dig (domain information groper - сборщик информации о домене) - это еще одна простая утилита DNS Lookup, которая используется для запроса информации, связанной с DNS, такой как A Record, CNAME, MX Record и т. д., например:
dig google.com

# Nslookup также является популярной утилитой командной строки для запросов DNS-серверов как в интерактивном, так и не интерактивном режиме. Nslookup используется для запроса записей ресурсов DNS (RR - resource records). Вы можете найти «A» запись (IP-адрес) домена, как показано ниже:
nslookup google.com
# Вы также можете выполнить обратный поиск домена.
nslookup 216.58.208.174

# Tcpdump - очень мощный и широко используемый сетевой анализатор командной строки. Он используется для захвата и анализа пакетов TCP/IP, переданных или полученных по сети через определенный интерфейс.
# Чтобы захватывать пакеты с заданного интерфейса, укажите его с помощью опции -i.
tcpdump -i eth1
# Чтобы захватить определенное количество пакетов, используйте параметр -c, чтобы ввести желаемое число.
tcpdump -c 5 -i eth1
# Вы также можете захватывать и сохранять пакеты в файл для последующего анализа, используйте флаг -w, чтобы указать выходной файл.
tcpdump -w captured.pacs -i eth1

# UFW - это широко известный и используемый по умолчанию инструмент настройки брандмауэра в дистрибутивах Debian и Ubuntu Linux. Он используется для включения и отключения системного брандмауэра, добавления, удаления, изменения, сброса правил фильтрации пакетов и многого другого.
# Чтобы проверить состояние брандмауэра UFW, введите:
sudo ufw status
# Если брандмауэр UFW не активен, вы можете активировать или включить его с помощью следующей команды.
sudo ufw enable
# Чтобы отключить брандмауэр UFW, используйте следующую команду.
sudo ufw disable

```
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


```console
sudo nano /etc/netplan/*.yaml

network:
  ethernets:
    enp0s3:
      dhcp4: false
      addresses: [192.168.2.30/24]
      gateway4: 192.168.2.1
    enp0s8:
      dhcp4: true
      addresses: [10.85.8.1/24]
    enp0s9:
      dhcp4: true
      addresses: [10.3.85.1/24]
  version: 2
```

---
Remove any configuration files .yaml present in the /etc/netplan directory.
```console
  sudo rm -rf /etc/netplan/*
```

```console
sudo nano /etc/netplan/Serv_Int1.yaml
```
Remove any configuration files .yaml present in the /etc/netplan directory.
```console 
  sudo rm -rf /etc/netplan/*

network:
    ethernets:
        enp0s3:
            dhcp4: false
            addresses: [192.168.2.30/24]
            gateway4: 192.168.2.1
            nameservers:
              addresses: [8.8.8.8,8.8.4.4,192.168.2.1]
    version: 2

sudo netplan apply
```

```console
sudo nano /etc/netplan/Serv_Int2.yaml

network:
    ethernets:
        enp0s8:
            dhcp4: true
            addresses: [10.85.8.1/24]
            gateway4: 192.168.2.30
            nameservers:
              addresses: [8.8.8.8,8.8.4.4,10.85.8.1]
    version: 2

sudo netplan apply
```

```console
sudo nano /etc/netplan/Serv_Int3.yaml

network:
    ethernets:
        enp0s9:
            dhcp4: true
            addresses: [10.3.85.1/24]
            gateway4: 192.168.2.30
            nameservers:
              addresses: [8.8.8.8,8.8.4.4,10.3.85.1]
    version: 2

sudo netplan apply
```


***
Once done, run the Docker image and map the port to whatever you wish on
your host. In this example, we simply map port 8000 of the host to
port 8080 of the Docker (or whatever port was exposed in the Dockerfile):

```sh
docker run -d -p 8000:8080 --restart=always --cap-add=SYS_ADMIN --name=dillinger <youruser>/dillinger:${package.json.version}
```

> Note: `--capt-add=SYS-ADMIN` is required for PDF rendering.

Verify the deployment by navigating to your server address in
your preferred browser.

```sh
127.0.0.1:8000
```

[пример](http://example.com/ "Необязательная подсказка")


Вертикальные линии обозначают столбцы.

| Таблицы       | Это                | Круто |
| ------------- |:------------------:| -----:|
| столбец 3     | выровнен вправо    | $1600 |
| столбец 2     | выровнен по центру |   $12 |
| зебра-строки  | прикольные         |    $1 |

Внешние вертикальные линии (|) не обязательны и нужны только, чтобы сам код Markdown выглядел красиво. Тот же код можно записать так:

Markdown | не такой | красивый
--- | --- | ---
*Но выводится* | `так же` | **клево**
1 | 2 | 3