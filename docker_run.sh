#!/bin/sh
docker network create trionet
cd nginx
docker run -d -p 80:80 --name nginx --network trionet --mount type=bind,source=$(pwd)/nginx.conf,target=/etc/nginx/nginx.conf nginx
cd ../flask-app
docker build -t flask-app .
docker run -d -p 5000:5000 --name flask-app --network trionet flask-app
cd ../db
docker build -t mysql .
docker run -d --name mysql --network trionet mysql
