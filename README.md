# 开发环境，但是在 Docker 里

公共服务器上的环境真的太脏了，还动不动就坏掉。
我弄了个 docker 环境，~~来跟他们切割~~。

## 有什么

默认是有 gcc/g++, clang/clang++, llvm, cmake, ninja, python2, python3。
而且安装了 oh-my-zsh，装了 powerline10k 主题。还安装了一个 Neovim，
用的是 LunarVim 的配置。附了一份简单的配置文件进去。

安装过程中使用了一些 github 镜像，比方说 fastgit 之类的，
这是为了让构建尽可能快。
安装结束后都取消掉了镜像设置，这是为了保持默认的行为，免得我自己忘记还有代理这事。
~~别笑，我真的会忘。~~

可以用这条命令设置全局镜像：

```
git config --global url."https://hub.fastgit.xyz/".insteadOf "https://github.com/"
```

可以用这条命令取消全局镜像：

```
git config --global --remove-section url."https://hub.fastgit.xyz/"
```

## 怎么用

第一次启动：

```
docker build . -t dev-env-img && \
docker run --name dev-env -it dev-env-img
```

之后再次使用：

```
docker start -a -i dev-env
```

或许你是 docker 高手，但我还是需要提醒你：
镜像删除后所有的非持久数据都会丢失，
最好通过 `--mount` 或者 `--volume` 选项来把自己的数据挂载到某个外部目录或卷存储，
这样即使删除容器，数据也不会受影响。

`vim` 被设置成了 LunarVim 的别名，第一次启动的时候需要同步一些内容
，保持网络畅通，不然会失败捏（跟语法高亮有关，不影响正常使用）。

如果 `setup/config/` 目录下存在一个叫 xray.config.json 的文件，
它会被复制到镜像的 `~/.xray/` 目录下。同时还添加了 `run_xray`，`stop_xray`，`update_xray` 命令，
用于启动、停止、更新 xray。你还可以利用 `set_proxy_env`，`unset_proxy_env`，`test_proxy_env` 命令
来自动设置、取消、查看 `HTTP_PROXY`，`HTTPS_PROXY` 等环境变量。默认的端口写在
`~/.proxy.sh` 文件中，你需要把它修改得与你的端口配置文件一致。

## 目前的计划

参见 [TODO](./TODO.md)
