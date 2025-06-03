# Отчёт по проекту Linux #

## 1. Установка ОС ##

+ **Установка системы**

![Установка системы](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_1.png "Установка системы")

[Вывод команды `cat /etc/issue`]

## 2. Создание пользователя ##

+ **Создание пользователя**

![Создан новый пользователь keller](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_2-1.png "Создан новый пользователь keller")

[Создание пользователя с помощью утилиты `adduser` и добавление в группу adm командой `usermode -a -G adm`]

+ **Проверка пользователей**

![Вывод команды cat /etc/passwd](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_2-2.png "Вывод команды cat /etc/passwd")

[Вывод команды `cat /etc/passwd`]

## 3. Настройка сети ОС ##

+ **Переименование хоста**

![Меняем имя хоста](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_3-1.png "Меняем имя хоста")

[Изменение имени хоста с помощью команды `hostnamectl set-hostname` и его проверка командой `hostname`]

+ **Настройка временной зоны**

![Изменение временной зоны](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_3-2.png "Изменение временной зоны")

[Изменение временной зоны с помощью команды `timedatectl set-timezone` и его проверка командой `timedatectl`]

+ **Просмотр интерфейсов**

![Просмотр сетевых интерфейсов](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_3-3.png "Просмотр сетевых интерфейсов")

[Просмотр сетевых интерфейсов с помощью  `ip -br link show`]

+ **Получение ip-адреса от DHCP**

![Получение ip-адреса от DHCP](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_3-4.png "Получение ip-адреса от DHCP")

[Получение ip-адреса от DHCP с помощью `dhclient`]

*DHCP - Dynamic Host Configuration Protocol - сетевой протокол, позволяющий сетевым устройствам автоматически получать IP-адреса для работы в сетях TCP/IP. Он выполняет всю работу по подбору сетевых настроек автоматически, без необходимости присваивать вручную каждому устройству свой IP-адрес. Это очень упрощает работу системного администратора в случае расширения сети.*

+ **Внешний адрес шлюза, внутренний адрес шлюза** 

![Просмотр внешнего ip-адреса](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_3-5.png "Просмотр внешнего ip-адреса")

![Просмотр ip-адресов шлюза](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_3-6.png "Просмотр ip-адресов шлюза")

[Просмотр внешнего ip-адреса с помощью `curl` и ip-адресов шлюза с помощью `ip route`]

+ **Изменение ip вручную**

**Файл .yaml, который создаёт Netplan, система настройки сетевых интерфейсов**

```
ls /etc/netplan
sudo vim /etc/netplan/*.yaml
sudo netplan apply
```

![Меняем файл Netplan](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_4-1.png "Меняем файл Netplan")

![Файл до изменений](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_4-2.png "Файл до изменений")

[Файл до изменений]

![Файл после изменений](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_4-3.png "Файл после изменений")

[Файл после изменений]

![Сохраняем изменения](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_4-4.png "Сохраняем изменения")

+ **Проверка адреса интерфейса после перезагрузки**

![Проверяем адрес интерфейса](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_4-5.png "Проверяем адрес интерфейса")

![ip route](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_4-6.png "ip route")

![Проверяем DNS](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_4-7.png "Проверяем DNS")

[Вывод команд ip addr и ip route и проверка DNS с помощью команды `systemd-resolve --status | grep 'DNS Servers' -A2`]

+ **Пинг 1.1.1.1 и ya.ru**

![Пингуем 1.1.1.1](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_4-8.png "Пингуем 1.1.1.1")

![Пингуем ya.ru](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_4-9.png "Пингуем ya.ru")

[Пингуем хосты командой `ping -c 4`, чтобы ограничить количество отправляемых пакетов до 4, иначе он будет отправлять их до бесконечности или прерывания]

## 4. Обновление ОС ##

```
sudo apt upgrade
```
![Обновление пакетов](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_5-1.png "Обновление пакетов")

[Обновление системных пакетов выполнено]

## 5. Использование команды sudo ##

```
sudo usermode -aG sudo keller
```
![Предоставление прав sudo](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_5-2.png "Предоставление прав sudo пользователю и изменение имени устройства")

[Предоставление прав sudo и изменение имени компьютера под пользователем keller]

## 6. Установка и настройка службы времени ##

+ **Синхронизация времени**

```
sudo apt install --reinstall systemd-timesyncd
sudo dpkg-reconfigure tzdata
```
![Синхронизация времени](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_6.png "Синхронизация времени")

[Синхронизация времени через `systemd-timesyncd`]

## 7. Установка и использование текстовых редакторов##

```
sudo apt update
sudo apt install nano
sudo apt install mcedit
```

+ **Создание тестовых файлов**

```
vim test_vim.txt
i (INSERT mode)
delmerfi
esc
:wq //выход с сохранением
```
![delmerfi vim](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-1.png "delmerfi vim")

[Файл в вим]

```
nano test_nano.txt
delmerfi
^O //сохранение
^W //выход
```

![delmerfi nano](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-2.png "delmerfi nano")

[Файл в нано]

```
mcedit test_mcedit.txt
delmerfi
F2 //сохранение
F10 //выход
```

![delmerfi mcedit](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-3.png "delmerfi mcedit")

[Файл в mcedit]

+ **Выход без сохранения**

**Vim: :q!**

![21 School 21 vim](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-4.png "21 School 21 vim")

**Я: **

**Nano: ^X**
**Save buffer?: N**

![21 School 21 nano](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-5.png "21 School 21 nano")

**Mcedit: F10**

**Save file?: No**

![21 School 21 mcedit](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-6.png "21 School 21 mcedit")

+ **Поиск и замена.**

**Vim**

```
/School
```
![vim search](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-7.png "vim search")

[Поиск в vim]

```
:s/School/Test/
```
![vim replace](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-8.png "vim replace")

[Замена в vim]

**Nano**

```
^W
```

![nano search](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-9.png "nano search")

[Поиск в nano]

```
Alt+R
```

![nano replace 1](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-10.1.png "nano replace 1")

![nano replace 2](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-10.2.png "nano replace 2")

![nano replace result](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-10.3.png "nano replace result")

[Замена в nano]

**Mcedit**

```
F7 - поиск от курсора до конца документа
```

![mcedit search](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-11.1.png "mcedit search")

![mcedit search result](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-11.2.png "mcedit search result")

[Поиск в mcedit]

```
F4 - поиск и замена от курсора до конца документа
```

![mcedit replace](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-12.1.png "mcedit replace")

![mcedit replace result](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_7-12.2.png "mcedit replace result")

[Замена в mcedit]


## 8. Установка и базовая настройка SSHD ##

+ **Установка службы SSHd и добавление её в автозагрузку.**

```
sudo apt update
sudo apt install openssh-server
sudo systemctl enable ssh 
sudo systemctl start ssh
```

Последние две команды - для обхода бага, при котором не работает добавление ssh в автозагрузку командой `sudo systemctl enable sshd`

+ **Настройка порта 2022. Для этого откроем в редакторе нужный файл - обязательно под sudo, т.к. файл этот readonly, и изменим строку `#Port 22` на `Port 2022`. Затем перезапустим ssh.**

```
sudo vim /etc/ssh/sshd_config
i
#Port 22 -> Port 2022
:wq
sudo systemctl restart ssh
```
+ **Проверяем, что процесс запущен, используя `ps -C sshd`. Команда ps выводит список всех процессов с информацией о них - PIDом, названием, временем выполнения, активным терминалом. Процессов много, и искать в огромной таблице неудобно. Ключ -С позволит найти наш процесс по имени команды.**

![Вывод команды ps](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_8-1.png "Вывод команды ps")

[Вывод команды ps]

+ **Теперь перезапустим систему (через интерфейс VirtualBox или консольную команду `shutdown -r now`) и проверим через `netstat -tan`, что служба запустилась вместе с системой и настроена на нужный порт.**

![Вывод команды netstat -tan](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_8-2.png "Вывод команды netstat -tan")

[Вывод команды `netstat -tan`]

## 9. Установка и использование утилит top, htop ##

+ **Проверка состояниясистемы. Утилита top уже установлена, установим htop через `sudo apt install htop`.**

+ **Вывод top.**

![Вывод команды top](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_9-1.png "Вывод команды top")

[Вывод команды `top`]

1. Uptime - 51 минута на момент скриншота. 
2. Авторизованных пользователей - 1.
3. Общая нагрузка - отображается за 1 мин, 5 мин, 15 мин. У меня 0, 0 и 0. Вот так, совсем не нагружена система, пока отчёт пишу.
4. Всего процессов - 95.
5. Загрузка CPU - используется 1,4%, из них 0.3% - на пользовательские процессы (su), 0,7%- на процессы ядра (sy), 0,3% - программные прерывание (si). 98,6% - свободно (id).
6. Загрузка памяти - 143.9 используется, ещё 647.7 в буффере, 1177,9 свободно. Всего 1971.6.
7. PID процесса, занимающего больше всего памяти - 1.
8. PID процесса, занимающего больше всего процессорного времени - 1117.

+ **Вывод htop. **

**Сортировки (F6):**

![Сортировка вывода команды htop по PID](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_9-2.1.png "Сортировка вывода команды htop по PID")

[Сортировка вывода команды `htop` по PID]

![Сортировка вывода команды htop по PERSENT_CPU](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_9-2.2.png "Сортировка вывода команды htop по PERSENT_CPU")

[Сортировка вывода команды `htop` по PERSENT_CPU]

![Сортировка вывода команды htop по PERSENT_MEM](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_9-2.3.png "Сортировка вывода команды htop по PERSENT_MEM")

[Сортировка вывода команды `htop` по PERSENT_MEM]

![Сортировка вывода команды htop по времени](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_9-2.4.png "Сортировка вывода команды htop по времени")

[Сортировка вывода команды `htop` по времени]

+ **F4 - отфильтровать sshd-процесс:**

![Фильтр для sshd-процесса](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_9-3.png "Фильтр для sshd-процесса")

[Фильтр для sshd-процесса]

+ **F3 - поиск процесса syslog:**

![Поиск процесса по запросу syslog](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_9-4.png "Поиск процесса по запросу syslog")

[Поиск процесса по запросу syslog]

+ **F2 - изменим интерфейс. Добавим вывод hostname и time, кастомизируем вывод uptime:**

![Вывод hostname, clock, uptime](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_9-5.png "Вывод hostname, clock, uptime")

[Вывод hostname, clock, uptime]

## 10. Использование утилиты fdisk ##

+ **Проверка состояния жёсткого диска.**

![Вывод fdisk](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_10.png "Вывод fdisk")

[Вывод fdisk -l]

1. Название диска - /dev/sda.
2. Размер - 10 ГБ (столько и выделяли при создании виртуальной машины).
3. Кол-во секторов - 20971520.
4. Размер свап - 1,45 ГБ.

## 11. Использование утилиты df ##

+ **Выведем отдельно содержимое диска:**

![Вывод df](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_11-1.png "Вывод df")

[Вывод df]

1. Раздел - /dev/mapper/ubuntu--vg-ubuntu--lv.
2. Размер раздела - 8408452.
3. Размер занятого пространства - 4176264.
4. Размер свободного пространства - 3783472.
5. Процент использования - 53%.

Размер разделов выводится в блоках по 1 килобайту. 

+ **Более человекочитаемый формат размера**

![Вывод df -Th](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_11-2.png "Вывод df -Th")

[Вывод df -Th]

1. Раздел - /dev/mapper/ubuntu--vg-ubuntu--lv.
2. Размер раздела - 8.1 GB.
3. Размер занятого пространства - 4.0 GB.
4. Размер свободного пространства - 3.7 GB.
5. Процент использования - 53%.

Тип файловой системы - ext4

## 12. Использование утилиты du ##

+ **Ещё один способ заглянуть внутрь диска.**

![Вывод du](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_12-1.png "Вывод du")

[Вывод du]

+ **Вывод содержимого отдельных папок.**

```
sudo du -s -b /home - для вывода в байтах
sudo du -s -h /home - для человекочитаемого вывода
```

![Вывод du с флагами](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_12-2.png "Вывод du с флагами")

[Вывод du с флагами]

+ **Содержимое папки с логами.**

```
sudo du -h /var/log/*
```

![Вывод du с *](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_12-3.png "Вывод du с *")

[Вывод du с *]

+ **Вывод вложенных папок**

```
sudo du -ha /var/log/*
```

![Вывод du с -ha](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_12-4.1.png "Вывод du с -ha")

![Вывод du с -ha](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_12-4.2.png "Вывод du с -ha")

[Вывод du с -ha для показа размеров всех вложенных файлов и папок]

## 13. Установка и использование утилиты ncdu ##

+ **Анализ диска через ncdu.**

```
ncdu /home
ncdu /var
ncdu /var/log
```

![Вывод ncdu /home](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_13-1.png "Вывод ncdu /home")

[Вывод `ncdu /home`]

**Размер совпал с тем, который показала утилита du - 144 Mb.**


![Вывод ncdu /var](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_13-2.png "Вывод ncdu /var")

![Вывод ncdu /var/log](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_13-3.png "Вывод ncdu /var/log")

[Вывод `ncdu /var` и `ncdu var/log`]

**Здесь видно, что размер выше того, который показала du. Это объясняется разрывом во времени, с которым происходили обращения к утилите. Приведём здесь новый вывод утилиты du.**

![Вывод du](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_13-4.png "Вывод du")

[Вывод du]

## 14. Работа с системными журналами ##

+ **Просмотр системные журналы по адресам:**

1. /var/log/dmesg
2. /var/log/syslog
3. /var/log/auth.log

**Из последнего журнала узнаём информацию о входе:**

1. Время последней успешной авторизации - 14:34:34.
2. Имя пользователя - vtsab.
3. Метод входа - session opened for user vtsab by LOGIN(uid=0).

![Вход в систему](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_14-1.png "Вход в систему")

[Информация об аутентификации пользователя в системном журнале]

+ **Теперь перезапускаем sshd через `sudo systemctl restart sshd` и в том же журнале видим:**

![Информация о рестарте службы sshd](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_14-2.png "Информация о рестарте службы sshd")

[Информация о рестарте службы sshd]

## 15. Использование планировщика заданий CRON ##

**Добавим задачу в планировщик CRON. Для этого методом с помощью команды crontab -e отредактируем список задач и добавим туда строку `*/2 * * * * uptime`. Перезапустим cron. Теперь время в системе будет считываться в фоновом режиме каждые 2 минуты, каждый час, каждый день месяца, каждый месяц, каждый день недели. Проверим в журнале логов syslog:**

![Информация из логов о работе cron](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_15-1.png "Информация из логов о работе cron")

[Информация из логов о работе cron]

**Удостоверимся, что uptime успешно есть в списке задач:**

```
crontab -l
```

![Вывод crontab -l](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_15-2.png "Вывод crontab -l")

[Вывод списка задач cron командой `crontab -l`]

+ **Теперь очистим список задач**

```
crontab -r
crontab -l
```
![Вывод crontab -l после удаления всех задач](https://github.com/VTsabina/DevOps_projects/tree/main/Linux/datasets/Part_15-3.png "Вывод crontab -l после удаления всех задач")

[Вывод `crontab -l` после удаления всех задач]
