#!/usr/bin/env bash
#
if [ -S ~/.ssh/ssh_auth_sock ]; then
    # test that it's alive (note, this may only work on Win WSL bash)
    # I'm incrementing the pid of the ssh-agent in this case. It might
    # not be a universal truth to find the actual pid
    PID=$(readlink -f ~/.ssh/ssh_auth_sock | awk -F'.' '{print $2+1}')
    if ! kill -0 ${PID} 2>/dev/null; then
        rm $(readlink -f ~/.ssh/ssh_auth_sock)
    fi
fi
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval `ssh-agent` >/dev/null
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

