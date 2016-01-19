
export DATA=/opt/data

export DATANODE1=$DATA/datanode1
export DATALOG1=$DATA/datalog1
export DATANODE2=$DATA/datanode2
export DATALOG2=$DATA/datalog2
export NAMENODE=$DATA/namenode
export MASTERLOG=$DATA/masterlog
export DNS=dns
export DOMAIN=hadoop.docker
export NAMETMP=$DATA/nametmp
export DATATMP1=$DATA/datatmp1
export DATATMP2=$DATA/datatmp2
export MYSQLDB=$DATA/mysqldb

docker run --name $DNS -v /var/run/docker.sock:/docker.sock -d netacadoncall/dns --domain $DOMAIN

docker run --name mysqldb --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' $DNS) --dns-search $DOMAIN -h mysqldb -P -p 3306:3306 -e MYSQL_ROOT_PASSWORD=Test789! -e MYSQL_DATABASE=metastore -e MYSQL_USER=hive -e MYSQL_PASSWORD=Test123! -v $MYSQLDB:/var/lib/mysql -d mysql/mysql-server

docker run -d -t -e NODE_TYPE=s -P --name slave1 -p 8906:9000 -p 8908:50075 -v $DATATMP1:/usr/local/hadoop/tmp -v $DATANODE1:/usr/local/hadoop/data/datanode -v $DATALOG1:/usr/local/hadoop/logs --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' $DNS) --dns-search $DOMAIN -h slave1 mengyao/hadoop-dn bash

docker run -d -t -e NODE_TYPE=s -P --name slave2 -p 8904:9000 -p 8910:50075 -v $DATATMP2:/usr/local/hadoop/tmp -v $DATANODE2:/usr/local/hadoop/data/datanode -v $DATALOG2:/usr/local/hadoop/logs --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' $DNS) --dns-search $DOMAIN -h slave2 mengyao/hadoop-dn bash

docker run -d -t -e NODE_TYPE=n -P -p 8911:8080 -p 8903:8088 -p 8905:50070 -p 8907:9000 -p 8913:9083 -p 8914:10000 -v $NAMENODE:/usr/local/hadoop/data/namenode -v $MASTERLOG:/usr/local/hadoop/logs --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' $DNS) --dns-search $DOMAIN --name master -h master mengyao/hadoop-nn bash

docker exec -i master service sshd start
docker exec -i slave1 service sshd start
docker exec -i slave2 service sshd start

echo N | docker exec -i master hadoop namenode -format

#docker exec -i master start-all.sh

#docker exec -i master hive --service metastore &