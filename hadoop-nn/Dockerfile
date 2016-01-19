# Create master node for 3-node distributed hadoop 2.6.0

FROM mengyao/hadoop-base:latest
MAINTAINER Mengyao Gao

USER root

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync mysql-connector-java crontabs sendmail sendmail-cf cyrus-sasl-plain m4
RUN yum update -y libselinux

# hadoop configuration
ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop

ADD core-site.xml.template $HADOOP_PREFIX/etc/hadoop/core-site.xml.template
RUN sed s/HOSTNAME/master/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml


RUN mkdir $HADOOP_PREFIX/tmp
RUN mkdir $HADOOP_PREFIX/data
RUN mkdir $HADOOP_PREFIX/data/namenode
RUN mkdir $HADOOP_PREFIX/data/datanode
ADD hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml

ADD mapred-site.xml $HADOOP_PREFIX/etc/hadoop/mapred-site.xml
ADD yarn-site.xml $HADOOP_PREFIX/etc/hadoop/yarn-site.xml
ADD capacity-scheduler.xml $HADOOP_PREFIX/etc/hadoop/capacity-scheduler.xml
ADD slaves $HADOOP_PREFIX/etc/hadoop/slaves

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

# Authentication configuration
ADD pwd $HADOOP_PREFIX/pwd

# workingaround docker.io build error
RUN ls -la /usr/local/hadoop/etc/hadoop/*-env.sh
RUN chmod +x /usr/local/hadoop/etc/hadoop/*-env.sh
RUN ls -la /usr/local/hadoop/etc/hadoop/*-env.sh

# fix the 254 error code
RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config
RUN echo "Port 2122" >> /etc/ssh/sshd_config


## Hive Installation

# Download
RUN curl -s http://apache.claz.org/hive/stable/apache-hive-1.2.1-bin.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && mv apache-hive-1.2.1-bin hive
ENV HIVE_HOME /usr/local/hive
ENV PATH $PATH:$HIVE_HOME/bin

# Config
ADD hive-config.sh $HIVE_HOME/bin/hive-config.sh
ADD hive-site.xml $HIVE_HOME/conf/hive-site.xml

RUN ln -s /usr/share/java/mysql-connector-java.jar $HIVE_HOME/lib/mysql-connector-java.jar
ENV HADOOP_USER_CLASSPATH_FIRST true

## Sqoop Installation
# Download
RUN curl -s http://supergsego.com/apache/sqoop/1.4.6/sqoop-1.4.6.bin__hadoop-2.0.4-alpha.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && mv sqoop-1.4.6.bin__hadoop-2.0.4-alpha sqoop
ENV SQOOP_HOME /usr/local/sqoop
ENV PATH $PATH:$SQOOP_HOME/bin

#Config
ADD sqoop-env.sh $SQOOP_HOME/conf/sqoop-env.sh
ADD sqoop-site.xml $SQOOP_HOME/conf/sqoop-site.xml
RUN curl -O https://jdbc.postgresql.org/download/postgresql-9.4-1201.jdbc4.jar
RUN mv postgresql-9.4-1201.jdbc4.jar $SQOOP_HOME/lib/

## Ports
# Hdfs ports
EXPOSE 9000 50010 50020 50070 50075 50090 19888 8030 8031 8032 8033 8042 8088 22 49707 2122 10000 9083 12000 12001
