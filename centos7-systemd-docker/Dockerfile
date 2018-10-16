# 镜像来源
FROM centos:centos7

# 镜像创建者
MAINTAINER chenming <cmhello88@gmail.com>

# 设置一个环境变量
ENV container docker

# 安装常用命令
RUN yum install -y wget

# 备份原有CentOS-Base.repo文件
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak

# 阿里云的yum源更新源安装扩展包
RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
    && yum makecache \
    && yum install -y epel-release

# 修改时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 运行命令
# 设置systemd
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# 挂载一个本地文件夹
VOLUME [ "/sys/fs/cgroup" ]

# 设置容器启动时的执行命令
CMD ["/usr/sbin/init"]
