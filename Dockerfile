#using base image nginx

FROM nginx:latest
#hear I am copy my html file from my local machine to container while creating image

COPY ./index.html   /usr/share/nginx/html/index.html

#exposing port 80 to reflect the message on webpage

EXPOSE 80
