#!/bin/bash
# This bash shell accesses the /root/pcaps directory (cd ...)
# Then it dumps the first 2 million full packets sent over eth0 to a file (tcpdump...)
# Then the script lists the files in the directory in order of decreasing modification time (ls -t)
# It then takes the list returned and shows only the lines starting with number 31 (tail -n +31)
# It then takes the remaining lines, newline delimited, and removes them... (xargs -d '\n' rm)
# This, in effect, keeps the newest thirty packet captures in the folder.
# Created by Adam Schinder
# Date: 23 Feb 2016
# Edit: 18 May 2016 - Keeping the packet count to 2,000,000 in case of a DOS attack...

PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

cd /root/pcaps

tcpdump -w eth0-`date +%Y-%m-%d`.pcap -c 2000000 -i eth0 -K -nnvx -s0

ls -t | tail -n +31 | xargs -d '\n' rm -f

