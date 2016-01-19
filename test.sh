#!/bin/bash +x

## docker run -d --name mengyao/dns -v /var/run/docker.sock:/docker.sock netacadoncall/dns --domain hadoop.local

#update_hosts

HOST_CONTENT=$(for i in `docker ps -a |grep -v NAMES | awk '{print $NF}'`; do
docker exec -it $i cat /etc/hosts |grep $i;
done)

echo "$HOST_CONTENT"

## vi /etc/hosts

for i in `docker ps -a |grep -v NAMES | awk '{print $NF}'`; do

echo "$i"

docker exec -it $i sh -c 'echo "$HOST_CONTENT" >> /etc/hosts'
done






#echo "$HOST_CONTENT" >> /etc/hosts
