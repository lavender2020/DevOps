#!/bin/bash

set -e

# install docker-ce

# pull Docker file to build docker image
docker build -t lavender.info/nginx:latest .

# run docker container
docker run -d --name nginx --restart=always -p 80:80 -p 4000:22 -p 9001:9001 lavender.info/nginx:latest

# check nginx start successfully
curl http://localhost

