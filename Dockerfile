FROM ubuntu:18.04

ENV FB_PKG filebeat-7.0.1-amd64.deb 

RUN apt-get update && apt-get install -y curl

RUN apt-get install -y nginx

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/$FB_PKG
RUN dpkg -i $FB_PKG

COPY config/filebeat.yml /etc/filebeat/filebeat.yml
RUN filebeat modules enable nginx

CMD /bin/bash 
