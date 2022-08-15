#!/bin/bash

# 请以 root 用户执行该脚本

# commandline arguments

username=""
password=""

_gcc="1"
_clang_llvm="1"
_zsh="0"
_omz="0"
_omz_p10k="0"
_conda="1"

_shell="bash"

valid_val () {
    [ $1 = "1" ] || [ $1 = "0" ]
}

while [ "$#" -gt 0 ]; do
    case $1 in 
        --username) username=$2; shift ;;
        --password) password=$2; shift ;;
        --gcc) valid_val $2 && _gcc=$2; shift ;;
        --clang_llvm) valid_val $2 && _clang_llvm=$2; shift ;;
        --conda) valid_val $2 && _conda=$2; shift ;;
        --zsh) valid_val $2 && _zsh=$2; shift ;;
        --omz) valid_val $2 && _omz=$2; shift ;;
        --omz_p10k) valid_val $2 && _omz_p10k=$2; shift ;;
    esac
    shift
done

[ "$username" = "" ] && echo "Provide a username!" && exit 1
[ "$password" = "" ] && echo "Provide a password!" && exit 1

c_cpp_choice="0"

[ "$_gcc" = "1" ] && [ "$_clang_llvm" = "0" ] && c_cpp_choice="1"
[ "$_gcc" = "0" ] && [ "$_clang_llvm" = "1" ] && c_cpp_choice="2"
[ "$_gcc" = "1" ] && [ "$_clang_llvm" = "1" ] && c_cpp_choice="3"

[ "$_zsh" = "1" ] && _shell="zsh"

chmod 777 /tmp/* -R

set -o xtrace

bash -x util/apt.sh && \
bash -x installer/core_install.sh && \
bash -x installer/zsh_install.sh $_zsh && \
bash -x installer/c_cpp_install.sh $c_cpp_choice && \
bash -x util/add_user.sh $username $password $_shell && \
su $username -c "bash -x installer/omz_install.sh $_omz" && \
su $username -c "bash -x installer/omz_p10k_install.sh $_omz_p10k" && \
su $username -c "bash -x installer/conda_install.sh $_conda $_shell" || exit 1
