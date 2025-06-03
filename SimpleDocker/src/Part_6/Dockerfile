FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf

COPY server.c /

RUN apt-get update && apt-get install libfcgi-dev -y && apt-get install spawn-fcgi -y && apt-get install gcc -y && gcc server.c -lfcgi -o server && rm -rf /var/lib/apt/lists && \
    useradd vtsab; \
    chown -R vtsab:vtsab /etc/nginx.nginx.conf; \
    chown -R vtsab:vtsab /var/cache/nginx; \
    chown -R vtsab:vtsab /home; \
    touch /var/run/nginx.pid; \
    chown -R vtsab:vtsab /var/run/nginx.pid; \
    chmod u-s usr/bin/newgrp; \
    chmod g-s usr/bin/expiry; \
    chmod g-s usr/bin/chage; \
    chmod u-s usr/bin/passwd; \
    chmod g-s usr/sbin/unix_chkpwd; \
    chmod u-s usr/bin/chsh; \
    chmod u-s usr/bin/gpasswd; \
    chmod u-s usr/bin/chfn; \
    chmod g-s usr/bin/wall; \
    chmod u-s usr/bin/umount; \
    chmod u-s usr/bin/mount; \
    chmod u-s usr/bin/su;

USER vtsab

HEALTHCHECK --interval=5s --timeout=10s --retries=3 CMD curl -sS 127.0.0.1 || exit 1

ENTRYPOINT service nginx start && spawn-fcgi -p 8080 ./server && nginx -s reload && tail -f /dev/null
