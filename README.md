# 开发环境，但是在 Docker 里

公共服务器上的环境真的太脏了，还动不动就坏掉。
我弄了个 docker 环境，~~来跟他们切割~~。

## 有什么

默认是有 gcc/g++, clang/clang++, llvm, cmake, ninja, python2, python3。
而且安装了 oh-my-zsh，装了 powerline10k 主题。还安装了一个 Neovim，
用的是 LunarVim 的配置。附了一份简单的配置文件进去。

安装过程中使用了一些 github 镜像，比方说 fastgit 之类的。
安装结束后都取消掉了，也就是说安装完之后没有全局的 github 镜像，
这是为了保持默认的行为，免得我自己忘记还有代理这事。也可以用

```
git config --global url."https://hub.fastgit.xyz/".insteadOf "https://github.com/"
```

设置全局镜像。

## 目前的计划

参见 [TODO](./TODO.md)
