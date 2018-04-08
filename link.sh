#!/usr/bin/env bash
ln -sf $HOME/.setting/zsh/.zshrc      $HOME/.zshrc
ln -sf $HOME/.setting/zsh/.oh-my-zsh/ $HOME/.oh-my-zsh
ln -sf $HOME/.setting/.tmux.conf      $HOME/.tmux.conf
git clone https://github.com/kuetan/.emacs.d.git $HOME/.emacs.d
