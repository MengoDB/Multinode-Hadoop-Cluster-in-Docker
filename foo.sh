#!/bin/bash
for i in `docker ps -a |grep -v NAMES | awk '{print $NF}'`; do
   docker inspect $i | grep 'Hostname"\|IPAddress' | awk -F'"' '{print $4}' | tr '\n' ' '
   echo
done
