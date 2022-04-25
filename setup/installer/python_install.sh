#!/bin/bash

# 请以 sudo 执行该脚本

choice=$1

case "${choice}" in
    1)
        sudo apt install -y python2
        ;;
    2)
        sudo apt install -y python3 python3-pip
        ;;
    3)
        sudo apt install -y python2 python3 python3-pip
        update-alternatives --install /usr/local/bin/python python /usr/bin/python2 2
        update-alternatives --install /usr/local/bin/python python /usr/bin/python3 3
        ;;
esac
