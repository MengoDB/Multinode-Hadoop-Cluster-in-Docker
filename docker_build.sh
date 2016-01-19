

mkdir /opt/data
export DATA=/opt/data
export HADOOPDOCKER=/opt/docker

mkdir $DATA/mysqldb
mkdir $DATA/datanode1
mkdir $DATA/datalog1
mkdir $DATA/datanode2
mkdir $DATA/datalog2
mkdir $DATA/namenode
mkdir $DATA/masterlog
mkdir $DATA/datatmp1
mkdir $DATA/datatmp2

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


cd $HADOOPDOCKER/hadoop-base && docker build -t mengyao/hadoop-base .

cd $HADOOPDOCKER/hadoop-dn && docker build -t mengyao/hadoop-dn .

cd $HADOOPDOCKER/hadoop-nn && docker build -t mengyao/hadoop-nn .
