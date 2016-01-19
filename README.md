# Multinode-Hadoop-Cluster-in-Docker
This will allow you to install 3-node Apache Hadoop 2.6.0 cluster in Docker. docker_build.sh is given to build images. start_cluster.sh is provided to start containers for master node and slave nodes automatically. Using Docker, it is easy to add nodes to the clusters by starting additional docker containers. Apache Sqoop 1.4.6 and Apache Hive 1.2.1 will be installed in the master node.


## Installation Steps

### Docker images build
The directory of docker files ($HADOOPDOCKER) needs to be declared in the build_cluster.sh.

(Optional) The default directory ($DATA) where hdfs located in physical disk is /opt/data. If you'd like to change the directory, please edit the build_cluster.sh first before building docker images.
```
$ sudo vi build_cluster.sh

# in the build_cluster.sh, the first three lines are to be edited.
 mkdir /opt/data
 export DATA=/opt/data
 export HADOOPDOCKER=/opt/docker
```

After setting the directories, excute the build_cluster.sh to build images. Three images (hadoop-base, hadoop-nn and hadoop-dn) are to be built. hadoop-base is a basic image that hadoop-nn and hadoop-dn images are based on. This can avoid dulplicate downloads and configuration. hadoop-nn is an image that contains namenode of the cluster, hive installation and sqoop installation. hadoop-dn is an image that contains datanode of the cluster.

```
$ sudo sh build_cluster.sh
```

### Docker containers creation

(Readme.md unfinished)
