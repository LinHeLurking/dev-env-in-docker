#!/bin/bash

# 请以 sudo 执行该脚本

username=$1
password=$2
shell=$3
echo "Adding user $username" && \
locale-gen en_US.UTF-8 && \
adduser --quiet --disabled-password --shell /bin/$shell --home /home/$username --gecos \"User\" $username &&\
echo "$username:$password" | chpasswd && \
usermod -aG sudo $username 
