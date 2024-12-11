FROM alpine:3.19.4

RUN apk update && \
	apk add --no-cache \
    nginx \
    openssl

EXPOSE 443

RUN mkdir -p /run/nginx /etc/nginx/ssl

RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FI/ST=Helsinki/L=Helsinki/O=42/OU=Hive/CN=vsavolai.42.fr"

RUN adduser -D -H -s /sbin/nologin -g www-data -G www-data www-data

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod 644 /etc/nginx/nginx.conf
RUN chmod 644 /etc/nginx/ssl/inception.crt
RUN chmod 600 /etc/nginx/ssl/inception.key


CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]