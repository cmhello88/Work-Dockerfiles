# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>
#
# Enriched by patterns found at https://github.com/openshift/postgresql/blob/master/9.4/Dockerfile.rhel7 by
#   Christoph Görn <goern@redhat.com>

# https://github.com/CentOS/CentOS-Dockerfiles.git
FROM centos:centos7
MAINTAINER chenming <cmhello88@gmail.com>

# Labels consumed by Red Hat build service
LABEL Component="nginx" \
      Name="centos/nginx-114-centos7" \
      Version="1.14.0" \
      Release="1"

# Labels could be consumed by OpenShift
LABEL io.k8s.description="nginx [engine x] is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP/UDP proxy server, originally written by Igor Sysoev." \
      io.k8s.display-name="nginx 1.14.0" \
      io.openshift.expose-services="80:http" \
      io.openshift.tags="nginx"

RUN yum -y install --setopt=tsflags=nodocs centos-release-scl-rh && \
    yum -y update --setopt=tsflags=nodocs && \
    yum -y install --setopt=tsflags=nodocs scl-utils libselinux-utils policycoreutils-python rh-perl526-scldevel scl-utils-build gd && \
    yum clean all
#    mkdir -p /usr/share/nginx/html
COPY soft/rh-nginx114* /
RUN rpm -ivh --excludedocs rh-nginx114-nginx-1.14.0-3.el7.x86_64.rpm rh-nginx114-runtime-1.14-6.el7.x86_64.rpm rh-nginx114-build-1.14-6.el7.x86_64.rpm rh-nginx114-scldevel-1.14-6.el7.x86_64.rpm rh-nginx114-1.14-6.el7.x86_64.rpm && \
    mkdir -p /usr/share/nginx/html && \
    rm -f rh-nginx114*

# Get prefix path and path to scripts rather than hard-code them in scripts
ENV CONTAINER_SCRIPTS_PATH=/usr/share/container-scripts/nginx \
ENABLED_COLLECTIONS=rh-nginx114

# When bash is started non-interactively, to run a shell script, for example it
# looks for this variable and source the content of this file. This will enable
# the SCL for all scripts without need to do 'scl enable'.
ENV BASH_ENV=${CONTAINER_SCRIPTS_PATH}/scl_enable \
    ENV=${CONTAINER_SCRIPTS_PATH}/scl_enable \
    PROMPT_COMMAND=". ${CONTAINER_SCRIPTS_PATH}/scl_enable"

# COPY config/nginx.conf /etc/
COPY config/scl_enable /usr/share/container-scripts/nginx/scl_enable
COPY config/container-entrypoint config/nginx114 /usr/local/bin/
RUN chmod +x /usr/local/bin/container-entrypoint /usr/local/bin/nginx114

# ADD https://git.centos.org/sources/httpd/c7/acf5cccf4afaecf3afeb18c50ae59fd5c6504910 /usr/share/nginx/html/
# RUN sed -i -e 's/Apache/nginx/g' -e '/apache_pb.gif/d' /usr/share/nginx/html/index.html
# RUN echo "nginx on CentOS7" > /usr/share/nginx/html/index.html

EXPOSE 80

USER nginx

ENTRYPOINT ["container-entrypoint"]
CMD [ "nginx114" ]
