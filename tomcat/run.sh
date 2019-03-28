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


# git clone Dockerfile for tomcat
git clone https://github.com/lavender2020/DevOps.git

# pull Docker file to build docker image
cd DevOps/tomcat/ && docker build -t lavender.info/tomcat:latest .

# run docker container
docker run -d --restart=always --name tomcat -p 8080:8080 -p 4001:22 -p 9002:9001 lavender.info/tomcat:latest

# wating for service starting
sleep 10

# check tomcat start successfully
STATUS=$(curl -s -o /dev/null -w '%{http_code}' http://localhost:8080)

if [ $STATUS -eq 200 ]; then
    echo "Tomcat running successfully."
    exit 0
else
    echo "Tomcat running unsuccessfully, please check your deployment."
    exit 1
fi

