user=$1

git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git /home/$user/.oh-my-zsh/custom/themes/powerlevel10k
sed -i "s/ZSH_THEME=\".*\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/g" /home/$user/.zshrc