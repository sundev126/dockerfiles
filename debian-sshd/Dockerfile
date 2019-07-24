FROM debian:buster
LABEL maintainer="https://github.com/sundev126"

# 默认创建用户docker
ENV USERNAME=docker \
    PASSWORD=docker
    

# 安装软件包
RUN DEBIAN_FRONTEND=noninteractive set -ex \
 # 使用中科大源
 && cp /etc/apt/sources.list /etc/apt/sources.list.bak \
 && sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
 && apt-get -y update \
 && apt-get -y upgrade \
 && apt-get install -y apt-utils apt-transport-https ca-certificates \
 # 启用https
 && sed -i 's#http://mirrors.ustc.edu.cn#https://mirrors.ustc.edu.cn#g' /etc/apt/sources.list \
 && apt-get -y update \
 && apt-get -y upgrade \
 && apt-get install dialog \
 && apt-get install -y --allow-unauthenticated man-db locales openssh-server sudo \
                       curl wget nano vim git telnet aptitude tmux \
                       bash-completion less htop \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY entrypoint.sh /usr/local/sbin/

# 创建sshd运行必须的目录
RUN mkdir /var/run/sshd \
 # 设置root不能通过密码登录
 && sed -ri 's/^#PermitRootLogin(\s+.*)/PermitRootLogin\1/' /etc/ssh/sshd_config \
 && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && locale-gen en_US.UTF-8 \
 && update-locale LANG=en_US.UTF-8 \
 && chmod +x /usr/local/sbin/entrypoint.sh

EXPOSE 22
VOLUME [ "/home" ]
ENTRYPOINT [ "entrypoint.sh" ]
CMD ["/usr/sbin/sshd", "-D" ]
