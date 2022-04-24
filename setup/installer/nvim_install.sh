#!/bin/bash

# 请以 sudo 执行该脚本

nvim_deb_url="https://ghproxy.com/https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.deb"
nvim_deb_sha256_url="https://ghproxy.com/https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.deb.sha256sum"

choice=$1

[ "$choice" = "1" ] && \
cd /tmp/ && \
wget $nvim_deb_url && \
wget $nvim_deb_sha256_url && \
got=$(sha256sum nvim-linux64.deb) && \
expected=$(cat nvim-linux64.deb.sha256sum) && \
[ "$got" = "$expected" ] && \
sudo apt install ./nvim-linux64.deb && \
rm ./nvim-linux64.deb && 
rm ./nvim-linux64.deb.sha256sum
