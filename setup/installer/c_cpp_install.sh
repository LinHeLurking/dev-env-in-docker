#!/bin/bash

# 请以 sudo 执行该脚本

choice=$1

case "${choice}" in
    1)
        # gcc/g++
        sudo apt install -y build-essential cmake ninja-build
        ;;
    2)
        # clang/clang++, llvm
        sudo apt install -y cmake ninja-build clang llvm
        ;;
    3)
        # gcc/g++, clang/clang++, llvm
        sudo apt install -y build-essential cmake ninja-build clang llvm
        ;;
    *)
        # Nothing
        ;;
esac
