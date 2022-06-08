#!/bin/bash

# 请以普通用户身份执行该脚本

choice="$1"
shell="$2"

[ "$choice" = "1" ] || exit 0
    
node -v && has_node="y" || has_node="n" && \
pip -V && has_pip="y" || has_pip="n" && \
cargo -V && has_cargo="y" || has_cargo="n" && \
git config --global url."https://hub.fastgit.xyz/".insteadOf "https://github.com/" && \
cd /home/$USER && \
curl https://gitee.com/mirrors/lunarvim/raw/master/utils/installer/install.sh > lvim_install_raw.sh && \
echo -e "$has_node\n$has_pip\n$has_cargo\n" | bash lvim_install_raw.sh && \
( \
  ( \
    [ -f /tmp/config/lvim.config.lua ] && \
    cp /tmp/config/lvim.config.lua "/home/$USER/.config/lvim/config.lua" && \
    sed -i "s/vim\.o\.shell = \"\/bin\/bash\"/vim\.o\.shell = \"\/bin\/zsh\"/" "/home/$USER/.config/lvim/config.lua" \
  ) || \
  true \ 
) && \
/home/$USER/.local/bin/lvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerUpdate' && \
git config --global --remove-section url."https://hub.fastgit.xyz/" && \
echo "alias vi=\"/home/$USER/.local/bin/lvim\"" >> "/home/$USER/.${shell}rc" && \
echo "alias vim=\"/home/$USER/.local/bin/lvim\"" >> "/home/$USER/.${shell}rc"

