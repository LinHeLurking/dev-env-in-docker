#!/bin/sh

user=$1

node -v && has_node="y" || has_node="n" && \
pip -V && has_pip="y" || has_pip="n" && \
cargo -V && has_cargo="y" || has_cargo="n" && \
cd /home/$user && \
curl https://gitee.com/mirrors/lunarvim/raw/master/utils/installer/install.sh > lvim_install_raw.sh && \
echo -e "$has_node\n$has_pip\n$has_cargo\n" | bash lvim_install_raw.sh
