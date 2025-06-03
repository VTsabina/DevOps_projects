FROM nginx

USER root

COPY nginx.conf /etc/nginx/nginx.conf

COPY server.c /

RUN apt-get update && apt-get install libfcgi-dev -y && apt-get install spawn-fcgi -y && apt-get install gcc -y && gcc server.c -lfcgi -o server

ENTRYPOINT service nginx start && spawn-fcgi -p 8080 ./server && nginx -s reload && tail -f /dev/null
