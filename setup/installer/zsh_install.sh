#!/bin/bash

# 请以 sudo 执行该脚本

choice=$1

[ "$choice" = "1" ] || exit 0

sudo apt install -y zsh fonts-powerline
