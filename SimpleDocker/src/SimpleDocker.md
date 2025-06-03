## Part 1. Готовый докер ##

 + **Скачаем nginx и проверим, что image сохранился.**

![Pull & images](datasets/Part_1-1.png "Docker pull & docker images")

+ **Запускаем контейнер**

![Run & ps](datasets/Part_1-2.png "Docker run & docker ps")

+ **Теперь выведем docker inspect**

![Docker inspect](datasets/Part_1-3.1.png "Docker inspect")

![Docker inspect](datasets/Part_1-3.2.png "Docker inspect")

![Docker inspect](datasets/Part_1-3.3.png "Docker inspect")

![Docker inspect](datasets/Part_1-3.4.png "Docker inspect")

![Docker inspect](datasets/Part_1-3.5.png "Docker inspect")

![Docker inspect](datasets/Part_1-3.6.png "Docker inspect")

![Docker inspect](datasets/Part_1-3.7.png "Docker inspect")

+ **Итог:**

+ ip = 172.17.0.2

+ ports = 80/tcp : null - что логично, т.к. пока порты не прокинуты

+ size = 187 MB

+ **Размер можно посмотреть проще через docker ps -as

![Docker ps -as](datasets/Part_1-3.8.png "Docker ps -as")

+ **Останавливаем контейнер**

![Docker stop](datasets/Part_1-4.png "Docker stop")

+ **Теперь прокинем порт 80:80 (таким же образом вписывается и порт 443:443)**

![Docker run](datasets/Part_1-5.png "Docker run")

+ **Подключимся к локалхосту**

![Getting ip](datasets/Part_1-6.1.png "Getting ip")

![Welcome to nginx](datasets/Part_1-6.png "Welcome to nginx")

+ **Рестарт**

![Restart](datasets/Part_1-7.png "Restart")

## Part 2. Операции с контейнером ##

+ **Запуск контейнера**

![Exec](datasets/Part_2-1.png "Exec")

+ **Посмотрим файл конфигурации**

![Nginx.conf](datasets/Part_2-2.png "Nginx.conf")

+ **Скопируем файл конфигурации к себе на локальную машину и изменим его**

![New nginx.conf](datasets/Part_2-3.1.png "New nginx.conf")

+ **Теперь скопируем его обратно и перезагрузим nginx**

![Docker cp & reload](datasets/Part_2-3.2.png "Docker cp & reload")

+ **Это было то, чего хотели в задании. Сейчас параметры сервера nginx лежат в отдельном файле /etc/nginx/conf.d/default.conf. И сделать так, как выше, конечно, можно - страница со статусом у нас появится, но перестанет отвечать главная страница. Чтобы такого не было, надо менять именно default.conf. Выглядеть это будет так:**

![Default.conf](datasets/Part_2-3.3.png "Default.conf")

+ **Итоговый результат**

![Status page](datasets/Part_2-4.png "Status page")

+ **Экспорт.**

![Export](datasets/Part_2-5.png "Export")

+ **Удаляем сначала образ (принудительно, потому что он иначе не удалится до удаления контейнера), потом сам контейнер. И делаем импорт.**

![Rmi, rm, import](datasets/Part_2-6.png "Rmi, rm, import")

+ **Запуск через скрипт с эндпойнтом**

![Docker run/start](datasets/Part_2-7.png "Docker run/start")
