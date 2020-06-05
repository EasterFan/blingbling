<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [dockerfile 语法和最佳实践](#dockerfile-语法和最佳实践)
  - [FROM](#from)
  - [LABEL](#label)
  - [RUN](#run)
  - [WORKDIR](#workdir)
  - [ADD && COPY](#add--copy)
  - [ENV](#env)
  - [VOLUME](#volume)
  - [EXPOSE](#expose)
  - [CMD && ENTRYPOINT](#cmd--entrypoint)
- [Dockerfile 进行 debug](#dockerfile-进行-debug)
- [把静态网页装进 docker](#把静态网页装进-docker)
- [参考](#参考)
<!-- TOC END -->

# dockerfile 语法和最佳实践
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
- dockerfile 的核心命令，用于根据命令创建一层新的镜像层
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
格式为VOLUME ["/data"]。

创建一个可以从本地主机或其他容器挂载的挂载点，一般用来存放数据库和需要保持的数据等。

## EXPOSE


## CMD && ENTRYPOINT
- CMD ：容器启动（docker run）以后，默认执行的命令和参数，CMD 被覆盖的原因是：CMD 是默认执行的命令，优先级比较低，如果命令行中带参数，参数会自动覆盖CMD
- ENTRYPOINT：容器（docker run）的启动后执行的命令
- 在写Dockerfile时, ENTRYPOINT或者CMD命令会自动覆盖之前的ENTRYPOINT或者CMD命令.
- CMD 和 ENTRYPOINT 有两种写法 shell（）和 exec（）
- 推荐写一个 shell 脚本并用 ENTRYPOINT 执行

```bash
# shell 格式
RUN apt-get install -y vim
ENV name shell
CMD echo "hello world"
ENTRYPOINT echo "hello $name"

# exec 格式
RUN [”apt-get“, “install”, “-y”, “vim”]
ENV name exec
CMD ["bin/echo", "hello world"]
ENTRYPOINT ["bin/bash", "-c", "echo hello $name"]
```

`docker run`启动容器时, 如果需要在命令行中传入对应参数，比如启动一个容器时(一个命令行工具容器，里面只装了一个 stress 命令行工具)，希望容器运行 `stress -vm --verbose`命令，通过 CMD + ENTRYPOINT 组合，可以实现这种效果  

```bash
FROM  ubuntu
RUN apt-get update && apt-get install -y stress
ENTRYPOINT ["usr/bin/stress"]
CMD []
```
启动`docker run -it imageName --vm 1 --verbose`

# Dockerfile 进行 debug
在使用 `docker build` 命令从 Dockerfile 文件创建镜像的过程中，如果 Dockerfile 写的有错误导致 `docker build` 失败，怎样 debug 定位到 Dockerfile 中的错误？  

执行 `docker build` 后，根据报错信息定位到构建失败的镜像是在哪一层，然后将这个镜像启动成容器，进入到容器中查看错误。

# 把静态网页装进 docker
使用 nginx 做静态服务器
Dockerfile 内容：
```
FROM nginx:alpine
LABEL creater="aaa" description="这是一个静态网站" version="1.0"
COPY . /usr/share/nginx/html
EXPOSE 80
```

```bash
# 创建 Dockerfile
touch Dockerfile
# 生成镜像（注意 . 表示当前目录）
docker build -t resume-image:v1 .
# 启动容器，然后在浏览器访问 localhost 访问
docker run -d -p 80:80 resume-image:v1
```



# 参考
- https://docs.docker.com/engine/reference/builder/#entrypoint
