#!/bin/bash

# 请以普通用户身份执行该脚本

choice=$1

[ "$choice" = "1" ] && \
cd /home/$USER && \
curl https://gitee.com/mirrors/ohmyzsh/raw/master/tools/install.sh | \
sed "s/REPO=\${REPO:\-ohmyzsh\/ohmyzsh}/REPO=\${REPO:\-mirrors\/ohmyzsh}/g" | \
sed "s/https:\/\/github\.com\//https:\/\/gitee.com\//g" > omz_install_raw.sh && \
echo Y | sh omz_install_raw.sh && \
cd .oh-my-zsh && \
git remote set-url origin https://gitee.com/mirrors/ohmyzsh.git && \
git pull
