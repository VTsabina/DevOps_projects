## Part 1. Инструмент ipcalc ##

### 1.1. Сети и маски ###

 + **Адрес сети 192.167.38.54/13 - 192.160.0.0/13**

![ipcalc 192.167.38.54/13](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_1.1-1.png "Результат вывода `ipcalc 192.167.38.54/13` с графой Network")

 + **Перевод маски 255.255.255.0 в префиксную и двоичную запись, /15 в обычную и двоичную, 11111111.11111111.11111111.11110000 в обычную и префиксную**

 + **Хотелось бы, чтобы ipcalc работал с двоичной записью, но он не работает. Благо, двоичную запись маски легко перевести в префиксную, посчитав количество единиц**

1. 255.255.255.0 = /24, 11111111.11111111.11111111.00000000

2. /15 = 255.254.0.0, 11111111.11111110.00000000.00000000

3. 11111111.11111111.11111111.11110000 = /28, 255.255.255.240

![Просмотр разной записи маски с помощью ipcalc](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_1.1-2.png "Просмотр разной записи маски с помощью ipcalc")

 + **Аналогично находим инимальный и максимальный хост в сети 12.167.38.4 при масках: /8, 11111111.11111111.00000000.00000000, 255.255.254.0 и /4, где /16 - это 11111111.11111111.00000000.00000000**

![Просмотр минимальных и максимальных хостов с помощью ipcalc](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_1.1-3.1.png "Просмотр минимальных и максимальных хостов с помощью ipcalc")

![Просмотр минимальных и максимальных хостов с помощью ipcalc](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_1.1-3.2.png "Просмотр минимальных и максимальных хостов с помощью ipcalc")

1. /8: min = 12.0.0.1, max = 12.255.255.254
2. /16: min = 12.167.0.1, max = 12.167.255.254
3. /4: min = 0.0.0.1, max = 15.255.255.254
4. 255.255.254.0: min = 12.167.38.1, max = 12.167.39.254

### 1.2. localhost ###

 + **Можно обратиться к приложению, работающему на localhost, со следующими IP: 127.0.0.2, 127.1.0.1, т.к. диапазон 127.001 - 127.255.255.255 зарезервирован для локальной сети. На выводе ipcalc по максимальному и минимальному хосту видно, что только эти адреса укладываются в допустимый диапазон 127.0.0.1 - 127.255.255.254.**

![Просмотр допустимых адресов для localhost](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_1.2.png "Просмотр допустимых адресов для localhost")

### 1.1. Диапазоны и сегменты сетей ###

 + **Адреса:** 134.43.0.2, 172.0.2.1, 172.68.0.2, 192.172.0.1, 192.169.168.1 - можно использовать в качестве глобальных.

**Адреса:** 10.0.0.45, 10.10.10.10, 172.16.255.255, 172.20.250.4, 192.168.4.2 - можно использовать только как частные, т.к. диапазоны:

10.0.0.0 - 10.255.255.255

100.64.0.0 - 100.127.255.255

172.16.0.0 - 172.31.255.255

192.168.0.0 - 192.168.255.255 - не маршрутизируются в глобальной сети. Иными словами, они не уникальны.

 + **У сети 10.10.0.0/18 возможны следующие IP адресов шлюза: 10.10.0.2, 10.10.10.10, 10.10.1.255.**

![Просмотр допустимых адресов для 10.10.0.0/18](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_1.3.png "Просмотр допустимых адресов для 10.10.0.0/18")

**Адреса 10.0.0.1 и 10.10.100.1 не войдут в диапазон 10.10.0.1 - 10.10.63.254.**

## Part 2. Статическая маршрутизация между двумя машинами ##

 + **Поднимаем вторую машину**

 + **Вывод ip a для каждой ВМ:**

![Вывод ip a для ws1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_2.0-inter1.png "Вывод ip a для ws1")

![Вывод ip a для ws2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_2.0-inter2.png "Вывод ip a для ws2")

+ **Сетевой интерфейс внутренней сети - enp0s3. Зададим следующие адреса и маски: ws1 - 192.168.100.10, маска /16, ws2 - 172.24.116.8, маска /12.**

![Содержание изменённого файла etc/netplan/00-installer-config.yaml для ws1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_2.0-yaml1.png "Содержание изменённого файла etc/netplan/00-installer-config.yaml для ws1")

![Содержание изменённого файла etc/netplan/00-installer-config.yaml для ws1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_2.0-yaml2.png "Содержание изменённого файла etc/netplan/00-installer-config.yaml для ws1")

+ **Применим изменения с помощью netplan apply и убедимся, что всё сработало:**

![Проверка изменений для ws1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_2.0-netplan_apply1.png "Проверка изменений для ws1")

![Проверка изменений для ws2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_2.0-netplan_apply2.png "Проверка изменений для ws2")

### 2.1. Добавление статического маршрута вручную ###

+ **Добавим статический маршрут от одной машины до другой и обратно при помощи команды вида ip r add и пропингуем соединение:**

![Добавление маршрута от ws1 к ws2 и пинг соединения](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_2.1-ping1.png "Добавление маршрута от ws1 к ws2 и пинг соединения")

![Добавление маршрута от ws2 к ws1 и пинг соединения](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_2.1-ping2.png "Добавление маршрута от ws2 к ws1 и пинг соединения")

### 2.1. Добавление статического маршрута с сохранением ###

 + **Перезапустим машины.** 

 + **Теперь сделаем так, чтобы наши маршруты не слетали после перезапуска. Для этого добавим статический маршрут от одной машины до другой с помощью файла etc/netplan/00-installer-config.yaml:**

![Файл etc/netplan/00-installer-config.yaml для ws1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_2.2-yaml_route1.png "Файл etc/netplan/00-installer-config.yaml для ws1")

![Файл etc/netplan/00-installer-config.yaml для ws2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_2.2-yml_route2.png "Файл etc/netplan/00-installer-config.yaml для ws2")

 + **Сохраним всё и пропингуем соединение между машинами:**

![Пинг соединения от ws1 к ws2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_2.2-apply_ping1.png "Пинг соединения от ws1 к ws2")

![Пинг соединения от ws2 к ws1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_2.2-apply_ping2.png "Пинг соединения от ws2 к ws1")

## Part 3. Утилита iperf3 ##

### 3.1. Скорость соединения ###

1. 8 Mbps = 1 MB/s
2. 100 MB/s = 800000 Kbps
3. 1 Gbps = 1000 Mbps.

### 3.2. Утилита iperf3 ###

 + **Измерим скорость соединения при сервере на ws1:**

![Вывод сервера ws1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_3.1-ws1-server1.png "Вывод сервера ws1")

![Вывод клиента ws2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_3.1-ws1-server2.png "Вывод клиента ws2")

 + **Измерим скорость соединения при сервере на ws2:**

![Вывод сервера ws2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_3.1-ws2-server1.png "Вывод сервера ws2")

![Вывод клиента ws1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_3.1-ws2-server2.png "Вывод клиента ws1")

## Part 4. Сетевой экран ##

### 4.1. Утилита iptables ###

 + **Создадим файл /etc/firewall.sh, который будет имитировать фаерволл. Откроем на обеих машинах порты 22 и 80 и изменим параметр эхо-реплай:**

 + **Первый пошёл:**

![Файл фаерволла на ws1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_4.1-firewall-file1.png "Файл фаерволла на ws1")

 + **Второй пошёл:**

![Файл фаерволла на ws2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_4.1-firewall-file2.png "Файл фаерволла на ws2")

+ **Запуск:**

![Запуск фаерволла на ws1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_4.1-firewall-start1.png "Запуск фаерволла на ws1")

![Запуск фаерволла на ws2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_4.1-firewall-start2.png "Запуск фаерволла на ws2")

**Для первой машины пинг сначала запрещается, потом разрешается. Для второй - наоборот, сначала разрешается, потом запрещается. В конце первая машина пинговаться будет, а вторая - не будет.**

### 4.2. Утилита nmap ###

 + **Убедимся, что вторая машина не пингуется.**

**Проверим с помощью nmap, что ай-пи второй машины всё ещё в сети:**

![Попытка пинга ws2 c ws1 и вывод nmap](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_4.2-nmap.png "Попытка пинга ws2 c ws1 и вывод nmap")

## Part 5. Статическая маршрутизация сети ##

 + **Поднимаем пять виртуальных машин**

### 5.1. Настройка адресов машин ###

**Настроим файлы конфигураций. И сразу пропингуем всё и со всем, чтобы убедиться, что мы не облажались:**

+ **R1**

![Файл .*yaml на r1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.1-r1-yaml.png "Файл .*yaml на r1")

![Пинг на r1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.1-r1-ping.png "Пинг на r1")

+ **R2**

![Файл .*yaml на r2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.1-r2-yaml.png "Файл .*yaml на r2")

![Пинг на r2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.1-r2-ping.png "Пинг на r2")

+ **WS11**

![Файл .*yaml на ws11](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.1-ws11-yaml.png "Файл .*yaml на ws11")

![Пинг на ws11](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.1-ws11-ping.png "Пинг на ws11")

+ **WS21**

![Файл .*yaml на ws21](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.1-ws21-yaml.png "Файл .*yaml на ws21")

![Пинг на ws21](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.1-ws21-ping.png "Пинг на ws21")

+ **WS22**

![Файл .*yaml на ws22](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.1-ws22-yaml.png "Файл .*yaml на ws22")

![Пинг на ws22](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.1-ws22-ping.png "Пинг на ws22")

### 5.2. Включение переадресации IP-адресов ###

**Включаем переадресацию на роутерах:**

+ **Без сохранения: **

![Результат sysctl -w net.ipv4.ip_forward=1 на r1 и r2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.2-r1-r2-forward.png "Результат sysctl -w net.ipv4.ip_forward=1 на r1 и r2")

+ **С сохранением, изменяя файлы конфигураций:**

![Файл /etc/sysctl.conf на r1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.2-r1-file.png "Файл /etc/sysctl.conf на r1")

![Файл /etc/sysctl.conf на r2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.2-r2-file.png "Файл /etc/sysctl.conf на r2")

### 5.3. Установка маршрута по умолчанию ###

+ **Дефолтный шлюз настроим с помощью gateway4. И сразу проверим:**

+ **R1**

![Файл .*yaml на r1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.3-r1-default-yaml.png "Файл .*yaml на r1")

![Вывод ip r на r1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.3-r1-ip-r.png "Вывод ip r на r1")

+ **R2**

![Файл .*yaml на r2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.3-r2-default-yaml.png "Файл .*yaml на r2")

![Вывод ip r на r2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.3-r2-ip-r.png "Вывод ip r на r2")

+ **WS11**

![Файл .*yaml на ws11](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.3-ws11-default-yaml.png "Файл .*yaml на ws11")

![Вывод ip r на ws11](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.3-ws11-ip-r.png "Вывод ip r на ws11")

+ **WS21**

![Файл .*yaml на ws21](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.3-ws21-default-yaml.png "Файл .*yaml на ws21")

![Вывод ip r на ws21](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.3-ws21-ip-r.png "Вывод ip r на ws21")

+ **WS22**

![Файл .*yaml на ws22](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.3-ws22-default-yaml.png "Файл .*yaml на ws22")

![Вывод ip r на ws22](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.3-ws22-ip-r.png "Вывод ip r на ws22")

+ **Теперь пропингуем WS11 и R2 и посмотрим, что выдаст tcpdump:**

![Пинг r2 на ws11](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.3-ws1-to-r2-ping.png "Пинг r2 на ws11")  

![Вывод tcpdump на r2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.3-r2-tcpdump.png "Вывод tcpdump на r2")

### 5.4. Добавление статических маршрутов ###

+ **Добавим для роутеров статические маршруты:**

+ **R1**

![Файл .*yaml на r1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.4-r1-yaml.png "Файл .*yaml на r1")

![Вывод ip r на r1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.4-r1-ip-r.png "Вывод ip r на r1")

+ **R2**

![Файл .*yaml на r2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.4-r2-yaml.png "Файл .*yaml на r2")

![Вывод ip r на r2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.4-r2-ip-r.png "Вывод ip r на r2")

+ **А теперь посмотрим на вывод ip r list 10.10.0.0/[маска сети] и ip r list 0.0.0.0/0 на WS11:**

![Вывод ip r list на ws11](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.4-ws11-ip-r.png "Вывод ip r list на ws11")

**Маршрут для 10.10.0.0 отличается от 0.0.0.0, поскольку этот адрес указывает на все адреса.**

### 5.5. Построение списка маршрутизаторов ###

+ **Запустим tcpdump -tnv -i enp0s3 на r1 и с помощью traceroute обратимся с WS11 к WS21:**

![Вывод traceroute, список маршрутизаторов на пути от ws11 до ws21](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.5-ws11-traceroute.png "Вывод traceroute, список маршрутизаторов на пути от ws11 до ws21")

![Вывод tcpdump на r1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.5-r1-dump.png "Вывод tcpdump на r1")

### 5.6. Использование протокола ICMP при маршрутизации ###

+ **Запустим на r1 tcpdump -n -i eth0 icmp и попробуем пропинговать с WS11 несуществующий хост:**

![Попытка пинга с ws11](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.6-ws11-ping.png "Попытка пинга с ws11")

![Вывод tcpdump на r1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_5.6-r1-dump.png "Вывод tcpdump на r1")

## Part 6. Динамическая настройка IP с помощью DHCP ##

+ **Поменяем файлы конфигураций r2 в соответствии с заданием и перезапустим сервер.**

![Файл dgcpd.conf r2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_6.1-r2-dhcpd-conf.png "Файл dgcpd.conf r2")

![Файл resolv.conf r2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_6.1-r2-resolve-conf.png "Файл resolv.conf r2")

![Перезапуск сервера](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_6.1-r2-restart-server.png "Перезапуск сервера")

![WS21 ip a](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_6.1-ws21-ip-a.png "WS21 ip a")

**Пропингуем WS21 и WS22 и убедимся, что они видят друг друга:**

![ws21-ws22-ping](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_6.1-ws21-ws22-ping.png "ws21-ws22-ping")

+ **Для второй части сети используем mac-адрес. Зададим mac-адрес для WS11 и заставим R1 выдавать ему ip по этому адресу:**

![Файл *.yaml ws11](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_6.1-ws11-mac-yaml.png "Файл *.yaml ws11")

![Файл dgcpd.conf r1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_6.1-r1-dhcpd-conf.png "Файл dgcpd.conf r1")

![Файл resolv.conf r1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_6.1-r1-resolve-conf.png "Файл resolv.conf r1")

**Пропингуем WS11, допустим, с WS21.**

![ws11-ws21-ping](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_6.1-ws11-ws21-ping.png "ws11-ws21-ping")

+ **Запросим адрес для WS21:**

![ws21-ip-a-before-dhclient](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_6.1-ws21-ip-a-before-dhclient.png "ws21-ip-a-before-dhclient")

```
dhclient -v
dhclient -r -v
dhclient -v
```

![ws21-ip-a-after-dhclient](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_6.1-ws21-ip-a-after-dhclient.png "ws21-ip-a-after-dhclient")

## Part 7. NAT ##

+ **Настройка Apache**

**Настроим файлы конфигурации на WS22 и R1. Они оба будут выглядеть так:.**

![ports-conf-ws22](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_7-ports-conf-ws22.png "ports-conf-ws22")

**Запуск**

![Запуск apache2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_7-apache-start-r1-ws22.png "Запуск apache2")

+ **Запустим на R2 имитацию файервола и проверим отсутствие пинга**

![Фаерволл на R2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_7-r2-firewall-iptables1.png "Фаерволл на R2")

![Старт фаерволла на R2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_7-firewall-start-r2.png "Старт фаерволла на R2")

![Пинг WS22 и R1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_7-ping-ws22-r1.png "Пинг WS22 и R1")

+ **Разрешим маршрутизацию пакетов**

![Фаерволл на R2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_7-r2-firewall-iptables2.png "Фаерволл на R2")

![Пинг WS22 и R1](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_7-ping-ws22-r1-after.png "Пинг WS22 и R1")

++ **Добавим SNAT и DNAT**

![Фаерволл на R2](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_7-r2-firewall-iptables3.png "Фаерволл на R2")

![Запрос с WS22 на R1 через telnet для проверки SNAT](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_7-ws22_SNAT.png "Запрос с WS22 на R1 через telnet для проверки SNAT")

![Запрос с R1 на WS22 через telnet для проверки DNAT](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_7-r1-DNAT.png "Запрос с R1 на WS22 через telnet для проверки DNAT")

## Part 8. Bonus. Знакомство с SSH Tunnels ##

![Получение доступа к серверу WS22 с WS21](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_8-ws21-to-ws22-telnet.png "Получение доступа к серверу WS22 с WS21")

![Получение доступа к серверу WS22 с WS11](https://github.com/VTsabina/DevOps_projects/blob/main/LinuxNetwork/datasets/Part_8-ws11-to-ws22-telnet.png "Получение доступа к серверу WS22 с WS11")
