#!/bin/bash

echo "Pulling ubuntu:14.04, debian, kali and metasploitable"
sudo docker pull ubuntu:14.04
sudo docker pull debain
sudo docker pull kalilinux/kali-linux-docker
sudo docker pull netsecframework/metasploitable:vulnstacktwo

echo "Available images"
sudo docker images 

echo "Starting kali, debian, ubuntu14.04, metasploitable"
sudo docker run -d -t --name=debian debian
sudo docker run -d -t --name=ubuntu14 ubuntu
sudo docker run -d -t --name=kali kalilinux/kali-linux-docker
sudo docker run -d -t  --name=metaexp  netsecframework/metasploitable:vulnstacktwo

echo "Running Images"
sudo docker ps 

