FROM alpine:3.19.4

RUN addgroup -S nginx && \
	adduser -S -G nginx -g nginx nginx

RUN apk update && apk add --no-cache \
	php81 \
	php81-phar \
	php81-curl \
	php81-fpm \
	php81-mysqli \
	php81-mbstring \
	php81-json \
	php81-gd \
	php81-xml \
	php81-zip \
	mariadb-client

EXPOSE 9000

RUN ln -s /usr/bin/php81 /usr/bin/php

RUN mkdir -p /run/php/ /var/www/html

COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

COPY ./tools/script.sh /
RUN chmod +x script.sh

ENTRYPOINT ["sh", "/script.sh"]