#!/bin/bash

# 普通用户权限

_choice=$1
_shell=$2

[ "${_choice}" = "1" ] || exit 0

_conda_install_prefix="/home/${USER}/miniconda3"

wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh && \
bash Miniconda3-py39_4.12.0-Linux-x86_64.sh -b -p ${_conda_install_prefix} && \
echo "channels:
  - defaults
show_channel_urls: true
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch-lts: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud" >> "/home/${USER}/.condarc" && \
${_conda_install_prefix}/bin/conda clean -i && \
${_conda_install_prefix}/bin/conda create -y --name "${USER}" python=3.8 && \
${_conda_install_prefix}/bin/conda init $_shell && \
echo "conda activate ${USER}" >> "/home/${USER}/.${_shell}rc" && \
${_conda_install_prefix}/bin/python3 -m pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple --upgrade pip && \
${_conda_install_prefix}/bin/python3 -m pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple

