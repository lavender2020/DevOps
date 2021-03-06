#!/bin/bash

set -e


# install docker-ce

sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce=18.06.0~ce~3-0~ubuntu -y

docker -v

if [ $? -eq 0 ]
then
  echo "Docker installed succefully."
else
  echo "Docker installed failed."
  exit 1
fi


# git clone Dockerfile for nginx
git clone https://github.com/lavender2020/DevOps.git

# pull Docker file to build docker image
cd DevOps/nginx/ && docker build -t lavender.info/nginx:latest .

# run docker container
docker run -d --name nginx --restart=always -p 80:80 -p 4000:22 -p 9001:9001 lavender.info/nginx:latest

# wating for service starting
sleep 10

# check nginx start successfully
STATUS=$(curl -s -o /dev/null -w '%{http_code}' http://localhost/static/index.html)

if [ $STATUS -eq 200 ]; then
    echo "Nginx running successfully."
    exit 0
else
    echo "Nginx running unsuccessfully, please check your deployment."
    exit 1
fi

