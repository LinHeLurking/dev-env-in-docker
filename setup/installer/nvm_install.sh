#!/bin/bash

# 请以普通用户执行该脚本

choice="$1"
shell="$2"

[ "$choice" = "1" ] || exit 0

curl https://raw.fastgit.org/nvm-sh/nvm/master/install.sh | $shell
