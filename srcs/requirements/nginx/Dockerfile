# FROM nginx:latest

# COPY conf/nginx.conf /etc/nginx/nginx.conf
# COPY html/sofia.html /usr/share/nginx/html
# COPY html/styles.css /usr/share/nginx/html

# EXPOSE 8080

FROM debian:bullseye

RUN mkdir -p /etc/nginx/ssl

RUN apt update && apt upgrade -y

RUN apt install -y nginx openssl

RUN openssl req \
-x509 \
-days 365 \
-nodes \
-newkey rsa:2048 \
-sha256 \
-subj "/C=PT/L=Lisbon/O=42 Lisboa/CN=shinckel.42.fr" \
-out /etc/nginx/ssl/shinckel.crt \
-keyout /etc/nginx/ssl/shinckel.key 

COPY conf/nginx.conf /etc/nginx/conf.d/

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]