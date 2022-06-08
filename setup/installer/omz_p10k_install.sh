#!/bin/bash

# 请以普通用户身份执行该脚本

choice=$1

[ "$choice" = "1" ] || exit 0

git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git /home/$USER/.oh-my-zsh/custom/themes/powerlevel10k && \
sed -i "s/ZSH_THEME=\".*\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/g" /home/$USER/.zshrc
