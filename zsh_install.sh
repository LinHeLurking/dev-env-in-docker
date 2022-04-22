#!/bin/sh

user=$1

cd /home/$user && \
curl https://gitee.com/mirrors/ohmyzsh/raw/master/tools/install.sh | \
sed "s/REPO=\${REPO:\-ohmyzsh\/ohmyzsh}/REPO=\${REPO:\-mirrors\/ohmyzsh}/g" | \
sed "s/https:\/\/github\.com\//https:\/\/gitee.com\//g" > zsh_install_raw.sh && \
echo Y | sh zsh_install_raw.sh && \
cd .oh-my-zsh && \
git remote set-url origin https://gitee.com/mirrors/ohmyzsh.git && \
git pull
