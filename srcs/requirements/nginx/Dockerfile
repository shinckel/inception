# FROM nginx:latest

# COPY conf/nginx.conf /etc/nginx/nginx.conf
# COPY html/sofia.html /usr/share/nginx/html
# COPY html/styles.css /usr/share/nginx/html

# EXPOSE 8080

FROM debian:bullseye
# bullseye is the codename for Debian 11

RUN echo "Dockerfile running for nginx"

RUN mkdir -p /etc/nginx/ssl

RUN apt update && apt upgrade -y

RUN apt install -y nginx openssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/shinckel.crt \
       -keyout /etc/nginx/ssl/shinckel.key \
       -subj "/C=PR/ST=Lisbon/L=Lisbon/O=42 School/OU=shinckel/CN=shinckel/"

COPY conf/nginx.conf /etc/nginx/conf.d/

RUN mkdir -p /run/nginx

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
