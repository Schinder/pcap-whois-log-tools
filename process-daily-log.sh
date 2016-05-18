#!/bin/bash
# This bash shell accesses the 
# This script navigates to the /root/info then reads the day's pcap file
# It teases out the src ip addresses by looking for the destinations that I sent a 'SYN ACK' to...
# It then sorts them, cuts off the port, and puts them into a text file...
# The for loop parses this file and for each unique address, performs a whois lookup
# It only displays certain data I felt like looking at, and places his data into a text file...
# Created by Adam Schinder
# Date: 23 Feb 2016
# Edit: 18 May 2016 - added the kill line to end the day's logging...

PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

cd /root/info

kill $(ps -aux | grep tcpdump | cut -d" " -f7)

tcpdump -r /root/pcaps/eth0-`date +%Y-%m-%d`.pcap -nn 'tcp[13]=0x12' | cut -d" " -f5 | sed 's/:$//' | rev | cut -d"." -f2- | rev | sort -u >> src-ips-`date +%Y-%m-%d`.txt

sleep 60

for x in $(cat src-ips-`date +%Y-%m-%d`.txt); do echo $x >> whois`date +%Y-%m-%d`.txt; echo -e '\n' >> whois`date +%Y-%m-%d`.txt; whois $x | grep 'rganization\|ddress\|ity\|tate\|ostal\|ountry\|erson\|hone' >> whois`date +%Y-%m-%d`.txt; echo -e '\n' >> whois`date +%Y-%m-%d`.txt; done

