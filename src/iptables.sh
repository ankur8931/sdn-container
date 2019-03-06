export pubintf=enp0s3
export privateintf=ovs-br1
sudo iptables -t nat -A POSTROUTING -o $pubintf -j MASQUERADE
sudo iptables -A FORWARD -i $privateintf -j ACCEPT
sudo iptables -A FORWARD -i $privateintf -o $pubintf -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -S
