#!/usr/bin/env bash

sudo apt-get install git gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev
sudo git clone git://github.com/yyuu/pyenv.git $HOME/.pyenv
source $HOME/.setting/zsh/.zshrc
pyenv intall 3.6.4
pyenv global 3.6.4
pyenv rehash
