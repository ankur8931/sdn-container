#!/bin/bash
sudo ovs-vsctl add-br ovs-br1
sudo ifconfig ovs-br1 192.168.3.37 netmask 255.255.255.0 up
sudo ifconfig ovs-br1

#Networking
sudo export pubintf=enp0s3
sudo export privateintf=ovs-br1
sudo iptables -t nat -A POSTROUTING -o $pubintf -j MASQUERADE
sudo iptables -A FORWARD -i $privateintf -j ACCEPT
sudo iptables -A FORWARD -i $privateintf -o $pubintf -m state --state RELATED,ESTABLISHED -j ACCEPT

#Connect to controller
sudo ovs-vsctl set-fail-mode ovs-br1 standalone
sudo ovs-vsctl set-controller ovs-br1 tcp:127.0.0.1:6633

