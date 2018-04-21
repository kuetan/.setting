#!/usr/bin/env bash

apt-get install -y git emacs zsh gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev
git clone git://github.com/yyuu/pyenv.git $HOME/.pyenv
$HOME/.setting/link.sh
source $HOME/.setting/zsh/.zshrc
echo "check_certificate = off" >> /etc/wgetrc
$HOME/.pyenv/bin/pyenv install 3.6.5
$HOME/.pyenv/bin/pyenv global 3.6.5
$HOME/.pyenv/bin/pyenv rehash
