#/bin/bash

# 请以 sudo 执行该脚本

sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo echo "deb http://mirrors.bfsu.edu.cn/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list
sudo echo "deb http://mirrors.bfsu.edu.cn/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list
sudo echo "deb http://mirrors.bfsu.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list
sudo echo "deb http://mirrors.bfsu.edu.cn/ubuntu/ focal-security main restricted universe multiverse"
sudo apt update
