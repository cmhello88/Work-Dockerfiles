FROM centos:centos7

MAINTAINER chenming <cmhello88@gmail.com>

# install dependencies for compiling hadoop
# openjdk-8-jdk \
# maven \
RUN yum update -y && \
    yum install -y wget \
                   libprotobuf-dev \
                   protobuf-compiler \
                   cmake \
                   build-essential \
                   pkg-config \
                   libssl-dev \
                   zlib1g-dev \
                   llvm-gcc \
                   automake \
                   autoconf \
                   make \
       		   openjdk-8-jdk \
		   maven

COPY compile.sh /root/compile.sh

RUN chmod +x /root/compile.sh
