#!/bin/sh

id $USERNAME>/dev/null 2>&1

if [ $? -ne 0 ];
    # user is not defined
    # 创建默认用户及home目录，并赋予sudo权限
    useradd \
        --create-home \
        --no-user-group \
        --password $(openssl passwd -1 $PASSWORD) \
        --groups users sudo \
        $USERNAME
    curl -o /home/$USERNAME/.vimrc \
        https://raw.githubusercontent.com/sundev126/dotfiles/master/vim/vimrc
    chown $USERNAME /home/$USERNAME/.vimrc
fi

exec "/usr/sbin/sshd -D"
