FROM nginx:alpine

COPY deploy/nginx.conf /etc/nginx/nginx.conf

COPY ./public/ /usr/share/nginx/html