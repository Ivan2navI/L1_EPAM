#!/bin/bash
# Объявление переменных
export FW="sudo iptables"

# Интерфейс, подключенный к Интернету
Int1_WAN="enp0s3"

# Интерфейсы, подключенные к локальной сети + Их диапазон адресов для этой локальной сети
Int2="enp0s8"
IP_2Client1="10.85.8.0/24"

Int3="enp0s9"
IP_2Client2="10.3.85.0/24"

# Очистка всех цепочек и удаление правил
$FW -F
$FW -F -t nat
$FW -F -t mangle
$FW -X
$FW -t nat -X
$FW -t mangle -X

# Разрешить входящий трафик к интерфейсу локальной петли,
# это необходимо для корректной работы некоторых сервисов
$FW -A INPUT -i lo -j ACCEPT

# Разрешить на внутреннем интерфейсе весь трафик из локальной сети Int2 (Client_1), Int3 (Client_2) к Server_1
$FW -A INPUT -i $Int2 -s $IP_2Client1 -j ACCEPT
$FW -A INPUT -i $Int3 -s $IP_2Client2 -j ACCEPT

# Разрешить входящие соединения, которые были разрешены в рамках других соединений
$FW -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Разрешить перенаправление трафика Ping с внутренней сети наружу, как для новых,
# так и уже имеющихся соединений в системе, остальные подключения в интернет - заблокировать.
#----- Для Client_1 настройки -----
#-- Позволяем два, наиболее безопасных типа пинга 8 (эхо-запрос) и 0 (эхо-ответ). --
$FW -A FORWARD -i $Int1_WAN -o $Int2 -p icmp --icmp-type 0 -m conntrack --ctstate NEW -j ACCEPT
$FW -A FORWARD -i $Int2 -o $Int1_WAN -p icmp --icmp-type 0 -m conntrack --ctstate NEW -j ACCEPT
#
$FW -A FORWARD -i $Int1_WAN -o $Int2 -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
$FW -A FORWARD -i $Int2 -o $Int1_WAN -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
#
$FW -A FORWARD -i $Int2 -o $Int3 -p icmp --icmp-type 0 -m conntrack --ctstate NEW -j ACCEPT
$FW -A FORWARD -i $Int2 -o $Int3 -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
#--	Позволяем DNS запрос --
$FW -A FORWARD -i $Int1_WAN -o $Int2 -p tcp -m tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
$FW -A FORWARD -i $Int2 -o $Int1_WAN -p tcp -m tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
$FW -A FORWARD -i $Int1_WAN -o $Int2 -p udp -m udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
$FW -A FORWARD -i $Int2 -o $Int1_WAN -p udp -m udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
#--	По умолчанию пакеты DROP, но для информирования клиента будет выполнен REJECT для интернет пакетов (80,443) --
$FW -A FORWARD -i $Int1_WAN -o $Int2 -p tcp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT
$FW -A FORWARD -i $Int2 -o $Int1_WAN -p tcp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT
$FW -A FORWARD -i $Int1_WAN -o $Int2 -p udp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT
$FW -A FORWARD -i $Int2 -o $Int1_WAN -p udp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT
#--	Разрешить перенаправление только тех пакетов с внешней сети внутрь, 						--
#--	которые уже являются частью имеющихся соединений + Обмен пакетами между внутренними сетями	--
$FW -A FORWARD -i $Int1_WAN -o $Int2 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
$FW -A FORWARD -i $Int2 -o $Int1_WAN -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
$FW -A FORWARD -i $Int2 -o $Int3 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
#--
#----- Для Client_2 настройки -----
#-- Позволяем два, наиболее безопасных типа пинга 8 (эхо-запрос) и 0 (эхо-ответ). --
$FW -A FORWARD -i $Int1_WAN -o $Int3 -p icmp --icmp-type 0 -m conntrack --ctstate NEW -j ACCEPT
$FW -A FORWARD -i $Int3 -o $Int1_WAN -p icmp --icmp-type 0 -m conntrack --ctstate NEW -j ACCEPT
#--
$FW -A FORWARD -i $Int1_WAN -o $Int3 -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
$FW -A FORWARD -i $Int3 -o $Int1_WAN -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
#--
$FW -A FORWARD -i $Int3 -o $Int2 -p icmp --icmp-type 0 -m conntrack --ctstate NEW -j ACCEPT
$FW -A FORWARD -i $Int3 -o $Int2 -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
#--	Позволяем DNS запрос --
$FW -A FORWARD -i $Int1_WAN -o $Int3 -p tcp -m tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
$FW -A FORWARD -i $Int3 -o $Int1_WAN -p tcp -m tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
$FW -A FORWARD -i $Int1_WAN -o $Int3 -p udp -m udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
$FW -A FORWARD -i $Int3 -o $Int1_WAN -p udp -m udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
#--	По умолчанию пакеты DROP, но для информирования клиента будет выполнен REJECT для интернет пакетов (80,443) --
$FW -A FORWARD -i $Int1_WAN -o $Int3 -p tcp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT
$FW -A FORWARD -i $Int3 -o $Int1_WAN -p tcp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT
$FW -A FORWARD -i $Int1_WAN -o $Int3 -p udp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT
$FW -A FORWARD -i $Int3 -o $Int1_WAN -p udp -m multiport --ports 80,443 -m conntrack --ctstate NEW -j REJECT
#--	Разрешить перенаправление только тех пакетов с внешней сети внутрь, 						--
#--	которые уже являются частью имеющихся соединений + Обмен пакетами между внутренними сетями	--
$FW -A FORWARD -i $Int1_WAN -o $Int3 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
$FW -A FORWARD -i $Int3 -o $Int1_WAN -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
$FW -A FORWARD -i $Int3 -o $Int2 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Выполняем трансляцию сетевых адресов, принадлежащих локальной сети
$FW -t nat -A POSTROUTING -o $Int1_WAN -s $IP_2Client1 -j MASQUERADE
$FW -t nat -A POSTROUTING -o $Int1_WAN -s $IP_2Client2 -j MASQUERADE

# Устанавливаем политики по умолчанию:
# Входящий трафик — сбрасывать; Проходящий трафик — сбрасывать; Исходящий — разрешать
$FW -P INPUT DROP
$FW -P FORWARD DROP
$FW -P OUTPUT ACCEPT

# Сохранить настройки в iptables
sudo iptables-save