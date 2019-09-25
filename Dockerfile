FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt -y install libffi-dev python-pip python-dev libssl-dev wkhtmltopdf curl git 
RUN curl --silent --location https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get -y install gcc g++ make
RUN apt-get install -y nodejs redis-server
RUN npm install -g yarn
RUN apt install -y nginx

RUN useradd -m -s /bin/bash erpnextuser -p 1234
RUN usermod -aG sudo erpnextuser
COPY ./install.py .
RUN python install.py --develop
RUN bench new-site example.com 
RUN bench start 

EXPOSE 8000-8005 9000-9005 3306-3307
