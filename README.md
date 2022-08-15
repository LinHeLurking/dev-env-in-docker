# 开发环境，但是在 Docker 里

公共服务器上的环境真的太脏了，还动不动就坏掉。
我弄了个 docker 环境，~~来跟他们切割~~。

## 有什么

默认是有 gcc/g++, clang/clang++, llvm, cmake, ninja, miniconda。
而且安装了 oh-my-zsh，装了 powerline10k 主题。

## 怎么用

构建：

```
bash ./build.sh --username <xxx> --password <xxx> --tag dev-img
```

之后使用：

```
docker run --name dev-env 
```

或许你是 docker 高手，但我还是需要提醒你：
镜像删除后所有的非持久数据都会丢失，
最好通过 `--mount` 或者 `--volume` 选项来把自己的数据挂载到某个外部目录或卷存储，
这样即使删除容器，数据也不会受影响。

## 说明

目前默认是以一个 cuda 镜像为 base，如果不跑深度学习，也可以换成别的。

## 扩展

可以通过添加脚本来增加安装的内容。脚本中有 zsh omz 等内容，为了快速构建，默认都没安装。详见 `setup/run_all.sh`。
