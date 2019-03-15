from scapy.all import *
import datetime
import csv

def checkRevDNS():

    for packet in packets:
       if packet.haslayer(DNSRR):
          if isinstance(packet.an, DNSRR):
             print(packet.an.rrname)

def readPacket(packets):

    pcap_list = list()

    for pkt in packets:
        time=datetime.datetime.fromtimestamp(pkt.time).strftime('%Y/%m/%d %H:%M:%S')
        ethsrc=pkt[Ether].src
        ethdst=pkt[Ether].dst
        ipsrc=pkt[IP].src
        ipdst=pkt[IP].dst
        proto=pkt[IP].proto
        sport=0
        dport=0
        
        #Flags
        fin=0
        sin=0
        rst=0
        psh=0
        ack=0
        urg=0
        ece=0
        cwr=0

        if pkt.haslayer(UDP):
           sport=pkt.sport
           dport=pkt.dport
        elif pkt.haslayer(TCP):
           sport=pkt.sport
           dport=pkt.dport
           
           if pkt[TCP].flags.F:
              fin=1
           if pkt[TCP].flags.S:
              sin=1
           if pkt[TCP].flags.R:
              rst=1
           if pkt[TCP].flags.P:
              psh=1
           if pkt[TCP].flags.A:
              ack=1
           if pkt[TCP].flags.U:
              urg=1
           if pkt[TCP].flags.E:
              ece=1
           if pkt[TCP].flags.C:
              cwr=1

        flowid = (str(ipsrc)+'-'+str(ipdst)+'-'+str(sport)+'-'+str(dport)+'-'+str(proto))

        print(flowid, ethsrc, ethdst, ipsrc, ipdst, proto, time, sport, dport, fin, sin, rst, psh, ack, urg, ece, cwr)
    
    return pcap_list

def listToCSV(pcap_list):

    with open('temp.csv', 'wb') as pcap_file:
         wr = csv.writer(pcap_file, quoting=csv.QUOTE_ALL)
         wr.writerow(pcap_list)

#main
packets = rdpcap('../data/traffic.pcap')
pcap_list = readPacket(packets)
#listToCSV(pcap_list)
