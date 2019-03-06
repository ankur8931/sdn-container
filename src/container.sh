#!/bin/bash

echo "Pulling ubuntu:14.04, debian, kali and metasploitable"
sudo docker pull ubuntu:14.04
sudo docker pull debain
sudo docker pull kalilinux/kali-linux-docker
sudo docker pull netsecframework/metasploitable:vulnstacktwo

echo "Available images"
sudo docker images 

echo "Starting kali, debian, ubuntu14.04, metasploitable"
sudo docker run -d -t --name=debian --net=none debian
sudo docker run -d -t --name=ubuntu14--net=none ubuntu
sudo docker run -d -t --name=kali --net=none kalilinux/kali-linux-docker

echo "Running Images"
sudo docker ps 


sudo ovs-docker add-port ovs-br1 eth0 ubuntu14 --ipaddress=192.168.3.39/24
sudo ovs-docker add-port ovs-br1 eth0 debian --ipaddress=192.168.3.40/24
sudo ovs-docker add-port ovs-br1 eth0 kali --ipaddress=192.168.3.41/24
