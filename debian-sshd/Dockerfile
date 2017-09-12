FROM       debian:stretch
MAINTAINER sundev "https://github.com/sundev126"

# 默认创建用户admin
ENV USERNAME=docker \
    PASSWORD=docker

RUN DEBIAN_FRONTEND=noninteractive set -ex \
 && apt-get -y update \
 && apt-get -y upgrade \
 && apt-get install -y --allow-unauthenticated apt-utils dialog man-db locales openssh-server sudo \
                       curl wget nano vim git telnet zsh aptitude tmux \
                       bash-completion less htop\
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 创建sshd运行必须的目录
RUN mkdir /var/run/sshd \
 # 设置root不能通过密码登录
 && sed -ri 's/^#PermitRootLogin(\s+.*)/PermitRootLogin\1/' /etc/ssh/sshd_config \
 && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && locale-gen en_US.UTF-8 \
 && update-locale LANG=en_US.UTF-8 \
 # 创建默认用户及home目录，并赋予sudo权限
 && useradd --create-home --user-group --shell /usr/bin/zsh --password $(openssl passwd -1 $PASSWORD) --groups sudo $USERNAME \
 ### START 设置默认用户的环境
 # 下载vim插件管理器vundle
 && su - $USERNAME -c "git clone https://github.com/VundleVim/Vundle.vim.git /home/$USERNAME/.vim/bundle/Vundle.vim" \
 # 安装oh-my-zsh
 &&  su - $USERNAME -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
 ### END

# 添加常用配置文件
COPY vimrc /home/$USERNAME/.vimrc
COPY tmux.conf /home/$USERNAME/.tmux.conf

# 修复权限
RUN chown $USERNAME:$USERNAME /home/$USERNAME/.vimrc \
 && chown $USERNAME:$USERNAME /home/$USERNAME/.tmux.conf


EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
