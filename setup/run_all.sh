#!/bin/bash

# 请以 root 用户执行该脚本

# commandline arguments

username=""
password=""

_gcc="1"
_clang_llvm="1"
_python2="1"
_python3="1"
_nvim="1"
_zsh="1"
_omz="1"
_omz_p10k="1"
_lvim="1"

shell="bash"

valid_val () {
    [ $1 = "1" ] || [ $1 = "0" ]
}

while [ "$#" -gt 0 ]; do
    case $1 in 
        --username) username=$2; shift ;;
        --password) password=$2; shift ;;
        --gcc) valid_val $2 && $_gcc=$2; shift ;;
        --clang_llvm) valid_val $2 && $_clang_llvm=$2; shift ;;
        --python2) valid_val $2 && $_python2=$2; shift ;;
        --python3) valid_val $2 && $_python3=$2; shift ;;
        --nvim) valid_val $2 && $_nvim=$2; shift ;;
        --zsh) valid_val $2 && $_zsh=$2; shift ;;
        --omz) valid_val $2 && $_omz=$2; shift ;;
        --omz_p10k) valid_val $2 && $_omz_p10k=$2; shift ;;
        --lvim) valid_val $2 && $_lvim=$2; shift ;;
    esac
    shift
done

[ "$username" = "" ] && echo "Provide a username!" && exit 1
[ "$password" = "" ] && echo "Provide a password!" && exit 1

c_cpp_choice="0"

[ "$_gcc" = "1" ] && [ "$_clang_llvm" = "0" ] && c_cpp_choice="1"
[ "$_gcc" = "0" ] && [ "$_clang_llvm" = "1" ] && c_cpp_choice="2"
[ "$_gcc" = "1" ] && [ "$_clang_llvm" = "1" ] && c_cpp_choice="3"

py_choice="0"

[ "$_python2" = "0" ] && [ "$_python3" = "1" ] && py_choice="2"
[ "$_python2" = "1" ] && [ "$_python3" = "0" ] && py_choice="1"
[ "$_python2" = "1" ] && [ "$_python3" = "1" ] && py_choice="3"

[ "$_zsh" = "1" ] && shell="zsh"

bash util/apt.sh && \
bash installer/core_install.sh && \
bash installer/zsh_install.sh $_zsh && \
bash installer/c_cpp_install.sh $c_cpp_choice && \
bash installer/python_install.sh $py_choice && \
bash installer/nvim_install.sh $_nvim && \
bash util/add_user.sh $username $password $shell && \
chown $username:$username -R /tmp/config && \
su $username -c "bash installer/omz_install.sh $_omz" && \
su $username -c "bash installer/omz_p10k_install.sh $_omz_p10k" && \
su $username -c "bash installer/lvim_install.sh" $_lvim $shell || exit 1

if [ "$_python3" = "1" ]; then
    su $username -c "python3 -m pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple --upgrade pip"
    su $username -c "python3 -m pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple"
fi
