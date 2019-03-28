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

# run jenkins docker container using official image
docker run --restart=always -d -p 80:8080 -p 50000:50000 -v /tmp/jenkins_home:/var/jenkins_home jenkins

# wating for service starting
sleep 10

# check nginx start successfully
STATUS=$(curl -s -o /dev/null -w '%{http_code}' http://localhost)

if [ $STATUS -lt 400 ]; then
    echo "Jenkins running successfully."
    exit 0
else
    echo "Jenkins running unsuccessfully, please check your deployment."
    exit 1
fi

