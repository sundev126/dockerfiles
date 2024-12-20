#!/bin/sh

id $USERNAME>/dev/null 2>&1

if [ $? -ne 0 ]; then
    # user is not defined
    # 创建默认用户及home目录，并赋予sudo权限
    useradd \
        --create-home \
        --no-user-group \
		--shell /bin/bash \
        --password $(openssl passwd -1 $PASSWORD) \
        --groups users,sudo \
        $USERNAME
    curl -s -o /home/$USERNAME/.vimrc \
        https://raw.githubusercontent.com/sundev126/dotfiles/master/vim/vimrc \
        2>/dev/null
    chown $USERNAME /home/$USERNAME/.vimrc
	curl -s -o /home/$USERNAME/.tmux.conf \
        https://raw.githubusercontent.com/sundev126/dotfiles/master/tmux/tmux.conf \
        2>/dev/null
    chown $USERNAME /home/$USERNAME/.tmux.conf
fi

/init