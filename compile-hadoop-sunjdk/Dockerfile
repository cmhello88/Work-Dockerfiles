FROM centos:centos7

MAINTAINER chenming <cmhello88@gmail.com>

ENV JAVA_VERSION 8
ENV JAVA_UPDATE 181
ENV JAVA_BUILD 13
ENV JAVA_PATH 96a7b8442fe848ef90c96a2fad6ed6d1
ENV JAVA_HOME /usr/local/jvm/default-jvm
ENV JAVA_DOWNLOAD_URL http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz
ENV JCE_DOWNLOAD_URL http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip

ENV MVN_HOME /usr/local/maven/default-mvn
ARG MAVEN_VERSION=3.5.4
ARG USER_HOME_DIR="/root"
ENV MVN_CONFIG "$USER_HOME_DIR/.m2"
ARG SHA=ce50b1c91364cb77efe3776f756a6d92b76d9038b0a0782f7d53acf1e997a14d
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries


# install dependencies for compiling hadoop
RUN yum update -y && \
    yum install -y wget \
		   gcc \
		   gcc-c++ \
                   libprotobuf-dev \
                   protobuf-compiler \
                   cmake \
		   zlib \
		   zlib-devel \
		   openssl \
                   openssl-devel \
                   build-essential \
                   pkg-config \
                   libssl-dev \
                   zlib1g-dev \
                   llvm-gcc \
                   automake \
                   autoconf \
                   make \
		   mkdir \
		   tar \
		   unzip \
                   ca-certificates \
    && mkdir -p ${JAVA_HOME} \
    && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" ${JAVA_DOWNLOAD_URL} \
    && tar -xzf jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz -C ${JAVA_HOME} --strip-components=1 \
    && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" ${JCE_DOWNLOAD_URL} \
    && unzip -jo -d ${JAVA_HOME}/jre/lib/security jce_policy-${JAVA_VERSION}.zip \
    && ln -s ${JAVA_HOME}/bin/* /usr/bin/ \
    && rm -rf jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz \
	       ${JAVA_HOME}/*src.zip \
	       ${JAVA_HOME}/jre/lib/security/README.txt \
	       jce_policy-${JAVA_VERSION}.zip \
           ${JAVA_HOME}/lib/missioncontrol \
           ${JAVA_HOME}/lib/visualvm \
           ${JAVA_HOME}/lib/*javafx* \
           ${JAVA_HOME}/jre/lib/plugin.jar \
           ${JAVA_HOME}/jre/lib/ext/jfxrt.jar \
           ${JAVA_HOME}/jre/bin/javaws \
           ${JAVA_HOME}/jre/lib/javaws.jar \
           ${JAVA_HOME}/jre/lib/desktop \
           ${JAVA_HOME}/jre/plugin \
           ${JAVA_HOME}/jre/lib/deploy* \
           ${JAVA_HOME}/jre/lib/*javafx* \
           ${JAVA_HOME}/jre/lib/*jfx* \
           ${JAVA_HOME}/jre/lib/amd64/libdecora_sse.so \
           ${JAVA_HOME}/jre/lib/amd64/libprism_*.so \
           ${JAVA_HOME}/jre/lib/amd64/libfxplugins.so \
           ${JAVA_HOME}/jre/lib/amd64/libglass.so \
           ${JAVA_HOME}/jre/lib/amd64/libgstreamer-lite.so \
           ${JAVA_HOME}/jre/lib/amd64/libjavafx*.so \
           ${JAVA_HOME}/jre/lib/amd64/libjfx*.so \
	&& mkdir -p ${MVN_HOME} /usr/local/maven/ref/ \
	&& curl -fsSL -o apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
	&& echo "${SHA}  apache-maven.tar.gz" | sha256sum -c - \
	&& tar -xzf apache-maven.tar.gz -C ${MVN_HOME} --strip-components=1 \
	&& ln -s ${MVN_HOME}/bin/mvn /usr/bin/mvn \
	&& rm -f apache-maven.tar.gz \
        && yum -y autoremove wget unzip mkdir \
        && yum clean all \
	&& rm -rf /var/cache/yum \
	          /tmp/*

COPY compile.sh /root/compile.sh
RUN chmod +x /root/compile.sh


#COPY mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY settings.xml ${MVN_CONFIG}/
#RUN chmod +x /usr/local/bin/mvn-entrypoint.sh

#ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
#CMD ["mvn"]
