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

__Увага!__ Якщо, адресний простір Net2, Net3 або Net4 перетинається з адресним 
простором Net1 – відповідну адресу можна змінити на власний розсуд. 
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


#### Install DHCP Server on Server_1 (Ubuntu 22.04.1 LTS)
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

####option domain-name "example.org";
####option domain-name-servers ns1.example.org, ns2.example.org;

####default-lease-time 600;
####max-lease-time 7200;

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
--- __Open DHCP Server Ports on Firewall__ --- \
Allow DHCP port on firewall for Server_1, Client_1, Client_2:
```console
sudo ufw allow  67/udp
```
Restart DHCP server to apply changes.
```console
sudo service isc-dhcp-server restart
# OR
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

__MODIFY SERVER_1__
```console
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
      dhcp4: false
      optional: true # to any devices that may not always be available. A start job is running without wait for network to be configured.
      # IP address/subnet mask
      addresses: [192.168.2.30/24]
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
    enp0s8: # To Client_1 (10.85.8.A)
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
    enp0s9: # To Client_2 (10.3.85.B)
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
sudo nano /etc/netplan/01-netcfg.yaml

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
      dhcp4: true
      optional: true

# !!! sudo apply changes
sudo netplan generate
sudo netplan apply
sudo systemctl restart systemd-networkd
ip addr 
```

__MODIFY Client_2__
```console
sudo nano /etc/netplan/01-netcfg.yaml

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
      dhcp4: true
      optional: true

# !!! sudo apply changes
sudo netplan generate
sudo netplan apply
sudo systemctl restart systemd-networkd
ip addr 
```


#### Configure NATing and Forwarding on Server_1
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
sudo iptables-save

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

#### Ping and Traceroute reluts between :computer: Client_1 :left_right_arrow: Server_1 :left_right_arrow: Client_2 :computer:
Ping commands send multiple requests (usually four or five) and display the results. The echo ping results show whether a particular request received a successful response. It also includes the number of bytes received and the time it took to receive a reply or the time-to-live.

Traceroute works by using the time-to-live (TTL) field in the IP header. Each router that handles an IP packet will decrease the TTL value by one. If the TTL reaches a value of zero, the packet is discarded and a "time exceeded" Type 11 Internet Control Message Protocol (ICMP) message is created to inform the source of the failure. Linux traceroute makes use of the User Datagram Protocol. Windows uses ICMP, and the traceroute command is tracert.
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/Pind_and_Traceroute.png">
</p>

## Answers: 4.
### 4. На віртуальному інтерфейсу lo Client_1 призначити дві ІР адреси за таким правилом: 172.17.D+10.1/24 та 172.17.D+20.1/24. Налаштувати маршрутизацію таким чином, щоб трафік з Client_2 до 172.17.D+10.1 проходив через Server_1, а до 172.17.D+20.1 через Net4. Для перевірки використати traceroute. 
 
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/My_Schem%20of%20Linux%20Networking%20(Loopback%20Interface).png">
</p>

#### Configure Loopback Interface for Client_1 
Net4 – 172.16.D.0/24 or 172.16.8.0/24 \
So, for Client_1 (lo) - 172.17.D+10.1/24 та 172.17.D+20.1/24, \
wiil be next: __172.17.18.1/24, 172.17.28.1/24__
```console
# TEST
sudo ip address add 172.17.18.1/24 dev lo
sudo ip address add 172.17.28.1/24 dev lo

# For netplan
network:
    version: 2
    renderer: networkd
    ethernets:
        lo:
            addresses: [172.17.18.1/24, 172.17.28.1/24]
```
#### Configure NETPLAN:
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/A4_1_Netplan_Conf.png">
</p>

#### Configure Packet Forwarding on Server_1:
ADD 2 rules for transfering packets Client_1 <=> Server_1 <=> Client_2  
```console
sudo iptables -A FORWARD -i enp0s8 -o enp0s9 -j ACCEPT
sudo iptables -A FORWARD -i enp0s9 -o enp0s8 -j ACCEPT

# Save current rules:
sudo iptables-save

sudo sh -c "iptables-save > /etc/iptables/rules.v4"
```
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/A4_2_SERVER_1_Conf_Packet_Forwarding.png">
</p>

#### Check traceroute from Client_2 to Client_1 (172.17.18.1/24 & 172.17.28.1/24):
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/A4_3_My_Schem of Linux Networking (Loopback Interface)_TraceRoute.png">
</p>


## Answers: 5.
### 5. Розрахувати спільну адресу та маску (summarizing) адрес 172.17.D+10.1 та 172.17.D+20.1, при чому префікс має бути максимально можливим. Видалити маршрути, встановлені на попередньому кроці та замінити їх об’єднаним маршрутом, якій має проходити через Server_1.

#### Summarizing:
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

#### Configuring Packet Forwarding through Server_1 for loopback interface Client_1 with Host Max IP 172.17.31.254/20:
| 172.17.16.0/20     |        Dec       |
| ------------------ |:----------------:|
| Host Max:          | 172.17.31.254    |

<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/A5_Netplan_Conf.png">
</p>

#### Check traceroute from Client_2 to Client_1 (loopback interface: 172.17.31.254/20) through Server_1:
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/A5_My_Schem of Linux Networking (Loopback Interface_Q5)_TraceRoute.png">
</p>

## Answers: 6.
### 6. Налаштувати SSH сервіс таким чином, щоб Client_1 та Client_2 могли підключатись до Server_1 та один до одного.  

#### Creating users ssh_user_4client1 & ssh_user_4client2 for connect to Client_1 (10.85.8.x), Client_2 (10.3.85.x) and Server_1 (10.85.8.1, 10.3.85.1).
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/A6_SSH_Connections.png">
</p>

#### Show All Active SSH Connections (for example on Server_1)
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/A6_Show_All_Active_SSH_Connections_Server_1.png">
</p>


## Answers: 7.
### 7. Налаштуйте на Server_1 firewall таким чином:
### - Дозволено підключатись через SSH з Client_1 та заборонено з Client_2 
### - З Client_2 на 172.17.D+10.1 ping проходив, а на 172.17.D+20.1 не проходив 

#### - Дозволено підключатись через SSH з Client_1 та заборонено з Client_2
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

Client_2 (10.3.85.x) :arrow_right: [trought Server_1] :arrow_right: Client_1 (10.85.8.x): \
:arrow_right: 172.17.18.1 - :ok: ALLOW :ok: \
:arrow_right: 172.17.28.1 - :no_entry: DENY :no_entry:

```console

# !!! Configure UFW for Client_1 like in previous example for Server_1

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

Let's execute PING, CURL requests from Client_1, Client_2, and also display the IPTABLES settings for Server_1.

Results of PING and CURL requests:
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/A8_1_PING_and_CURL.png">
</p>

__IP Tables on Server_1 before EDIT:__
```console
ubuntu@server1:~$ sudo iptables-save

# Generated by iptables-save v1.8.7 on Sun Nov 20 20:28:20 2022
*filter
:INPUT DROP [6:252]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT [104:18948]
-A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p tcp -m tcp --dport 53 -j ACCEPT
-A INPUT -p udp -m udp --dport 53 -j ACCEPT
-A FORWARD -i enp0s8 -o enp0s3 -j ACCEPT
-A FORWARD -i enp0s9 -o enp0s3 -j ACCEPT
-A FORWARD -i enp0s8 -o enp0s9 -j ACCEPT
-A FORWARD -i enp0s9 -o enp0s8 -j ACCEPT
-A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -p icmp -j ACCEPT
COMMIT
# Completed on Sun Nov 20 20:28:20 2022
# Generated by iptables-save v1.8.7 on Sun Nov 20 20:28:20 2022
*nat
:PREROUTING ACCEPT [8:356]
:INPUT ACCEPT [2:104]
:OUTPUT ACCEPT [4:294]
:POSTROUTING ACCEPT [1:78]
-A POSTROUTING -o enp0s3 -j MASQUERADE
COMMIT
# Completed on Sun Nov 20 20:28:20 2022
```

__!!! Use this script to change iptables:
[A8_IP_Tables_only_PING.sh](https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/A8_IP_Tables_only_PING.sh "A8_IP_Tables_only_PING.sh")__

__IP Tables on Server_1 AFTER EDIT:__
```console
ubuntu@server1:~$ sudo iptables-save
# Generated by iptables-save v1.8.7 
*filter
:INPUT DROP [0:0]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -i lo -j ACCEPT
-A INPUT -s 10.85.8.0/24 -i enp0s8 -j ACCEPT
-A INPUT -s 10.3.85.0/24 -i enp0s9 -j ACCEPT
-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i enp0s3 -o enp0s8 -p icmp -m icmp --icmp-type 0 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s8 -o enp0s3 -p icmp -m icmp --icmp-type 0 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s3 -o enp0s8 -p icmp -m icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s8 -o enp0s3 -p icmp -m icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s8 -o enp0s9 -p icmp -m icmp --icmp-type 0 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s8 -o enp0s9 -p icmp -m icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s3 -o enp0s8 -p tcp -m tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s8 -o enp0s3 -p tcp -m tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s3 -o enp0s8 -p udp -m udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s8 -o enp0s3 -p udp -m udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s3 -o enp0s8 -p tcp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT --reject-with icmp-port-unreachable
-A FORWARD -i enp0s8 -o enp0s3 -p tcp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT --reject-with icmp-port-unreachable
-A FORWARD -i enp0s3 -o enp0s8 -p udp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT --reject-with icmp-port-unreachable
-A FORWARD -i enp0s8 -o enp0s3 -p udp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT --reject-with icmp-port-unreachable
-A FORWARD -i enp0s3 -o enp0s8 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i enp0s8 -o enp0s3 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i enp0s8 -o enp0s9 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i enp0s3 -o enp0s9 -p icmp -m icmp --icmp-type 0 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s9 -o enp0s3 -p icmp -m icmp --icmp-type 0 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s3 -o enp0s9 -p icmp -m icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s9 -o enp0s3 -p icmp -m icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s9 -o enp0s8 -p icmp -m icmp --icmp-type 0 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s9 -o enp0s8 -p icmp -m icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s3 -o enp0s9 -p tcp -m tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s9 -o enp0s3 -p tcp -m tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s3 -o enp0s9 -p udp -m udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s9 -o enp0s3 -p udp -m udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
-A FORWARD -i enp0s3 -o enp0s9 -p tcp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT --reject-with icmp-port-unreachable
-A FORWARD -i enp0s9 -o enp0s3 -p tcp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT --reject-with icmp-port-unreachable
-A FORWARD -i enp0s3 -o enp0s9 -p udp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT --reject-with icmp-port-unreachable
-A FORWARD -i enp0s9 -o enp0s3 -p udp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT --reject-with icmp-port-unreachable
-A FORWARD -i enp0s3 -o enp0s9 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i enp0s9 -o enp0s3 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i enp0s9 -o enp0s8 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
COMMIT
# Completed on Sun Nov 20 21:36:05 2022
# Generated by iptables-save v1.8.7 
*nat
:PREROUTING ACCEPT [273:13463]
:INPUT ACCEPT [2:168]
:OUTPUT ACCEPT [1:76]
:POSTROUTING ACCEPT [2:168]
-A POSTROUTING -s 10.85.8.0/24 -o enp0s3 -j MASQUERADE
-A POSTROUTING -s 10.3.85.0/24 -o enp0s3 -j MASQUERADE
COMMIT
# Completed on Sun Nov 20 21:36:05 2022
```

Results after making changes to Server_1 iptables:
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main/4.%20Linux%20Networking/.settings/A8_2_PING_and_CURL.png">
</p>
