#!/bin/bash

# 请以 执行该脚本

mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb http://mirrors.bfsu.edu.cn/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.bfsu.edu.cn/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.bfsu.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.bfsu.edu.cn/ubuntu/ focal-security main restricted universe multiverse"
apt update
