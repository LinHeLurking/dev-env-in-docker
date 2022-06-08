#!/bin/bash

_choice=$1
_shell=$2

[ "${_choice}" = "1" ] || exit 0

/opt/conda/bin/conda create -y --name "${USER}" && \
/opt/conda/bin/conda init $_shell && \
echo "conda activate ${USER}" >> "/home/${USER}/.${_shell}rc"

