#!/bin/bash

addr="127.0.0.1"
port=$1
shell=$2

shell_rc="/home/$USER/.${shell}rc"

echo "export http_proxy=$addr:$port" >> $shell_rc
echo "export https_proxy=$addr:$port" >> $shell_rc
