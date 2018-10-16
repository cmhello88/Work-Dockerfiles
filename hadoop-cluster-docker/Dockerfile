FROM centos:centos7

MAINTAINER chenming <cmhello88@gmail.com>

USER root

WORKDIR /root

# install openssh-server, openjdk and wget
RUN yum -y update && yum install -y which openssh-server openssh-clients

# update libselinux. see https://github.com/sequenceiq/hadoop-docker/issues/14
# RUN yum update -y libselinux


# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P ''
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# passwordless ssh
#RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
#RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
#RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
#RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys


# java
#RUN curl -LO 'http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm' -H 'Cookie: oraclelicense=accept-securebackup-cookie'
COPY soft/jdk-8u181-linux-x64.rpm .
RUN rpm -i jdk-8u181-linux-x64.rpm
RUN rm jdk-8u181-linux-x64.rpm

ENV JAVA_HOME /usr/java/default
ENV PATH $PATH:$JAVA_HOME/bin
RUN rm /usr/bin/java && ln -s $JAVA_HOME/bin/java /usr/bin/java

# install hadoop
COPY soft/hadoop-2.8.5.tar.gz .
#RUN curl -LO http://apache.claz.org/hadoop/common/hadoop-2.8.5/hadoop-2.8.5.tar.gz | tar -xz -C /usr/local/
RUN tar -xzf hadoop-2.8.5.tar.gz -C /usr/local/
RUN rm hadoop-2.8.5.tar.gz
RUN cd /usr/local && ln -s ./hadoop-2.8.5 hadoop && ln -s /usr/local/hadoop/bin/hadoop /usr/bin/hadoop && ln -s /usr/local/hadoop/bin/hdfs /usr/bin/hdfs
# RUN mkdir -p /usr/local/hadoop && \
#    tar -xzvf /tmp/hadoop-2.8.5.tar.gz -C /usr/local/hadoop --strip-components=1 && \
#    rm -f /tmp/hadoop-2.8.5.tar.gz

# set environment variable
# ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64/jre 
ENV HADOOP_HOME=/usr/local/hadoop 
ENV HADOOP_LIBEXEC_DIR=$HADOOP_HOME/libexec 
ENV PATH=$PATH:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin 


#RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/java/default\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_HOME=/usr/local/hadoop\n:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
#RUN sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop/:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

#RUN mkdir $HADOOP_PREFIX/input
#RUN cp $HADOOP_PREFIX/etc/hadoop/*.xml $HADOOP_PREFIX/input

# pseudo distributed
#ADD core-site.xml.template $HADOOP_PREFIX/etc/hadoop/core-site.xml.template
#RUN sed s/HOSTNAME/localhost/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml
#ADD hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml

#ADD mapred-site.xml $HADOOP_PREFIX/etc/hadoop/mapred-site.xml
#ADD yarn-site.xml $HADOOP_PREFIX/etc/hadoop/yarn-site.xml


#ADD ssh_config /root/.ssh/config
#RUN chmod 600 /root/.ssh/config
#RUN chown root:root /root/.ssh/config


# fix the 254 error code
#RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
#RUN echo "UsePAM no" >> /etc/ssh/sshd_config
#RUN echo "Port 2122" >> /etc/ssh/sshd_config

RUN mkdir -p ~/hdfs/namenode && \ 
    mkdir -p ~/hdfs/datanode && \
    mkdir ${HADOOP_HOME}/logs

COPY config/* /tmp/

RUN mv /tmp/ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

RUN mkdir -p ${HADOOP_HOME}/etc ${HADOOP_HOME}/etc/hadoop && \
    mv /tmp/hadoop-env.sh ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml ${HADOOP_HOME}/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml ${HADOOP_HOME}/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml ${HADOOP_HOME}/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml ${HADOOP_HOME}/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves ${HADOOP_HOME}/etc/hadoop/slaves && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh

RUN chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x ${HADOOP_HOME}/sbin/start-dfs.sh && \
    chmod +x ${HADOOP_HOME}/sbin/start-yarn.sh 

# format namenode
RUN ${HADOOP_HOME}/bin/hdfs namenode -format
#RUN $HADOOP_PREFIX/bin/hdfs namenode -format

# workingaround docker.io build error
#RUN ls -la /usr/local/hadoop/etc/hadoop/*-env.sh
#RUN chmod +x /usr/local/hadoop/etc/hadoop/*-env.sh
#RUN ls -la /usr/local/hadoop/etc/hadoop/*-env.sh

CMD [ "sh", "-c", "systemctl start sshd; bash"]
