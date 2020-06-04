#!/bin/bash
#Filename: IPscanner.sh
#Functions: IP scan
#Author: Tony3201

if [ $USER != "root" ] 
then
 echo "You must be logged in as root." >&2
 exit 1
fi

network=$1
time=$(date +%H%M%S)

for i in $(seq $2 $3)
do
    ping -c 1 -w 2 $network.$i > /dev/null
    if [ $? -eq 0 ]; then
          arp $network.$i | grep ":" | awk '{print $1,$3}' >> $time.log
          echo "host $network.$i is up" |lolcat
   else
          echo "host $network.$i is X" >/dev/null
   fi
done
