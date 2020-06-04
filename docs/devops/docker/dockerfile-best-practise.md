# dockerfile 语法和最佳实践

>

```bash
#第一行必须指令基于的基础镜像 -
FROM ubutu

#维护者信息
MAINTAINER docker_user  docker_user@mail.com

#镜像的操作指令
RUN apt-get update && apt-get install -y ngnix
RUN echo "\ndaemon off;">>/etc/ngnix/nignix.conf

#容器启动时执行指令
CMD /usr/sbin/ngnix
```

## FROM
- FROM命令必须是Dockerfile的首个命令，
- 基础镜像可以为任何镜像，
- 如果镜像不依赖任何 base image（比如 hello-world 镜像，就应该使用 scratch 从头制作一个 base image）
- 尽量选择官方的 image 作为 base image - 为了安全

```bash
FROM scratch # 制作 base image
FROM ubuntu：14.04 # 使用 base image
```

## LABEL
- 必须在 FROM 后面

```bash
LABEL maintainer = "fdf@gmail.com"
LABEL version = "1.0"
LABEL description = "an introduce towards this project"
```

## RUN
- dockerfile 的核心命令，用于根据命令创建镜像
- 每执行一次 RUN 命令，都会在原来的镜像上累加一层（尽量将多个命令写在一个 RUN 命令里节约镜像层数，避免无用分层）
- RUN 命令过长用 “\” 换行 - 保持美观

```bash
# 反斜线换行
RUN yum update && yum install -y vim \
    python-dev
```

## WORKDIR
- 设定工作目录，如果目录不存在就创建
- WORKDIR 尽量用绝对目录代替相对目录
- 用 WORKDIR，不要用 RUN cd！

```bash
WORKDIR /test # 如果没有就在根目录下创建 test
WORKDIR demo
RUN pwd  # 输出结果应该是 /test/demo
```

## ADD && COPY
- 把 **当前目录中的本地文件** 添加到 image 里面
- ADD = copy + 解压
- 大部分情况下， COPY 优于解压
- ADD && COPY 用于添加本地文件，添加远程文件/目录要使用 `RUN curl 或者 wget`


```bash
ADD hello /
ADD test.tar.gz / # 添加到根目录并解压

WORKDIR /root
ADD hello test/  # 目录是 /root/test/hello
```

## ENV
- 多使用常量，增加代码可维护性

```bash
ENV MYSQL_VERSION 5.6 # 设置常量
RUN apt-get install -y mysql-server= "${MYSQL_VERSION}" \
    && rm -rf /var/lib/apt/list/*  # 引用常量
```

## VOLUME


## EXPOSE


## CMD && ENTRYPOINT
- CMD ：容器启动（docker run）以后，默认执行的命令，CMD 被覆盖的原因是：CMD 是默认执行的命令，优先级比较低，如果命令行中带参数，参数会自动覆盖CMD
- ENTRYPOINT：容器（docker run）的启动后执行的命令
- 在写Dockerfile时, ENTRYPOINT或者CMD命令会自动覆盖之前的ENTRYPOINT或者CMD命令.

### CMD 的三种形式


### ENTRYPOINT 的三种形式


# 把静态网页装进 docker

# 参考
- https://docs.docker.com/engine/reference/builder/#entrypoint
