#!/bin/bash

# 请以普通用户身份执行该脚本

choice=$1
shell=$2

set -x

[ "$choice" = "1" ] && \
node -v && has_node="y" || has_node="n" && \
pip -V && has_pip="y" || has_pip="n" && \
cargo -V && has_cargo="y" || has_cargo="n" && \
git config --global url."https://hub.fastgit.xyz/".insteadOf "https://github.com/" && \
cd /home/$USER && \
curl https://gitee.com/mirrors/lunarvim/raw/master/utils/installer/install.sh > lvim_install_raw.sh && \
echo -e "$has_node\n$has_pip\n$has_cargo\n" | bash lvim_install_raw.sh && \
mv /tmp/config/config.lua ~/.config/lvim/config.lua && \
/home/$USER/.local/bin/lvim +PackerInstall +PackerSync -es && \
git config --global --remove-section url."https://hub.fastgit.xyz/" && \
echo "alias vi=\"/home/$USER/.local/bin/lvim\"" >> "/home/$USER/.${shell}rc" && \
echo "alias vim=\"/home/$USER/.local/bin/lvim\"" >> "/home/$USER/.${shell}rc"
