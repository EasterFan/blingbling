<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [一. docker 介绍](#一-docker-介绍)
  - [docker 是什么](#docker-是什么)
  - [docker 三大核心思想](#docker-三大核心思想)
  - [docker 环境 - vagrant && virtualbox](#docker-环境---vagrant--virtualbox)
  - [docker 三大核心概念](#docker-三大核心概念)
    - [镜像](#镜像)
    - [容器](#容器)
    - [仓库](#仓库)
  - [docker 于我们的意义](#docker-于我们的意义)
- [二. docker 使用](#二-docker-使用)
  - [docker 安装](#docker-安装)
  - [docker 常用命令](#docker-常用命令)
  - [一个简单的 hello-world 跑全程](#一个简单的-hello-world-跑全程)
  - [一个简单的 nginx 跑全程](#一个简单的-nginx-跑全程)
  - [制作自己的 javaWeb 镜像   - jpress](#制作自己的-javaweb-镜像-----jpress)
- [三. 容器编排](#三-容器编排)
- [参考 && 学习资源](#参考--学习资源)
<!-- TOC END -->




# 一. docker 介绍

## docker 是什么
1. docker是一个可以装应用的程序，就像杯子装水一样，可以把hello-world、网站，任何你想到的程序放进docker。  
2. 它将linux容器中的应用代码打包，可以轻松的在服务器之间进行迁移。

## docker 三大核心思想
![](https://raw.githubusercontent.com/easterfan/picgo/master/blingbling/2020/dockerSprit.png)

- 集装箱  
docker将整个项目从操作系统开始分别打包到集装箱中，一个都不少，保证了项目100%的完整性  

- 运输方式标准化  
比如说，你想要把台式机的程序迁移到笔记本上  
传统：台式机---QQ/U盘---笔记本  
docker：台式机---超级码头---笔记本

- 存储方式标准化  
传统方式，将程序迁移到笔记本后，你要记住迁移的位置，下次迁移还要迁移到这个位置来。  
docker：你不需要关心从程序的存储位置，docker帮你管理  

- API接口标准化  
传统方式，你要启动程序，启动tomcat要一个命令，启动nginx要一个命令，即你要敲若干个命令才能让程序跑起来  
docker：docker提供了一系列REST API接口，包含对容器（即应用）的控制：启动/停止/查看/删除。  
在docker中，你只要运行一个`docker start`即可一键启动程序  

- 隔离  
虚拟机创建隔离环境几分钟，docker秒级创建  
隔离环境可被快速创建和销毁

## docker 环境 - vagrant && virtualbox
项目生产环境都是在 linux 中安装 docker，但是我们常用的系统是 mac 和 windows，vagrant 做的事情就是在 mac 上安装 centos，ubuntu 等虚拟环境，然后在虚拟环境中安装 docker。  

通常我们在 mac 上安装虚拟机通常是先在电脑上安装 vmware 或 virtualbox，然后去找对应的 centos 的 ISO 镜像安装成虚拟机，整个过程比较繁琐，在虚拟机的安装和删除上，vagrant 一行命令就可以完成。

安装 vagrant 环境 ：
```bash
brew cask install virtualbox
brew cask install vagrant
```

vagrant 常用命令：
```bash
# 初始化虚拟机 - https://vagrantcloud.com
vagrant init centos/7

# 启动环境
vagrant up

# 进入系统镜像
vagrant ssh

# 挂起虚拟机
vagrant suspend

#恢复被挂起的虚拟机
vagrant resume

# 强制关机
vagrant halt

# 获取虚拟机状态
vagrant global-status

# 销毁虚拟机
vagrant destroy
```

docker 清理空间：
```bash
# 查看 docker 占用空间
docker system df

# 清理空间 - 方便彻底但危险，需要确认一下
docker system prune -a --volumes
```

## Vagrantfile 需要修改的部分
1. 修改 vagrantfile，使虚拟机创建成功后，就自动安装 docker，各个系统安装命令见 docker 文档（注意 -y 静默安装，否则会安装失败）

```
config.vm.provision "shell", inline: <<-SHELL
  sudo yum install -y yum-utils
  sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
  sudo yum install -y docker-ce docker-ce-cli containerd.io
  sudo systemctl start docker
  sudo docker run hello-world
 SHELL
end
```

2. 修改默认的虚拟机的名字：

```bash
config.vm.provider "virtualbox" do |v|
    v.name = "test_environment"
end
```

3. 设置共享文件夹
```
config.vm.synced_folder   
   "your_folder"(必须)   //物理机目录，可以是绝对地址或相对地址，相对地址是指相对与vagrant配置文件所在目录
  ,"vm_folder(必须)"    // 挂载到虚拟机上的目录地址
  ,create(boolean)--可选     //默认为false，若配置为true，挂载到虚拟机上的目录若不存在则自动创建
  ,disabled(boolean):--可选   //默认为false，若为true,则禁用该项挂载
  ,owner(string):'www'--可选   //虚拟机系统下文件所有者(确保系统下有该用户，否则会报错)，默认为vagrant
  ,group(string):'www'--可选   //虚拟机系统下文件所有组( (确保系统下有该用户组，否则会报错)，默认为vagrant
  ,mount_options(array):["dmode=775","fmode=664"]--可选  dmode配置目录权限，fmode配置文件权限  //默认权限777
  ,type(string):--可选     //指定文件共享方式，例如：'nfs'，vagrant默认根据系统环境选择最佳的文件共享方式
```

## docker 三大核心概念
![](https://raw.githubusercontent.com/easterfan/picgo/master/blingbling/2020/docker-relationship.png)

### 镜像

1. 什么是镜像
鲸鱼驼着的所有集装箱的集合就是一个image。

2. 镜像的本质  
镜像的本质就是一系列文件。应用程序文件/应用环境文件等  

3. 镜像的存储格式  
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/imageStorage.png)
镜像的存储格式采用linux的联合文件系统格式。那是一种分层的文件系统，如图，它可以将不同的目录内容放在同一个虚拟文件系统下

4. 镜像的特点
上图从下而上的文件分别为：操作系统引导文件---操作系统---相关软件----writerable那层不是镜像，是容器  
镜像有一个特点，就是镜像每一层的文件系统都是只读的，不可修改

5. 构建镜像的目的  
构建镜像的目的，把我的代码完整的迁移到其他的机器或环境，使我的代码在其他机器上运行

6. 镜像的获取
- 通过 dockerfile 获取
- 通过 docker pull 获取

### 容器
1. 什么是容器
容器是由镜像生成的。镜像被下载到本地后，运行一个命令，使镜像最上层生成一个可读可写的容器。

2. 容器的本质
容器的本质，是一个隔离运行的进程

3. 当容器要写镜像时，该怎么办呢
我们把应用程序放在容器中跑，程序运行时，要写日志，要修改底层操作系统的一些配置，但我们知道，位于底层的镜像文件是只读的，这个时候，docker该怎么办？  
docker的做法：在写这个文件前，先把底层的镜像copy到最上层的容器中，再对该文件进行修改

4. 容器和虚拟机的区别
容器是更轻量的虚拟机。虚拟机通过中间层，将一台或多台独立的机器虚拟运行于**物理硬件**之上，docker则是直接运行于**操作系统内核**之上的用户空间。  

### 仓库
1. 仓库的作用
存储海量的镜像  

2. 谁提供仓库
docker官方：hub.docker.com  
我感觉dockerhub和github是很相似的，前者做的更彻底，又托管了代码，又托管了代码环境，github会不会被dockerhub取代？？

## docker 于我们的意义
- 开发：我本地运行没问题啊！运维为什么跑不通？  
首先，我们来分析一下，一个应用跑起来依赖的是什么？  
从下往上有：**操作系统-JDK-Tomcat-代码-配置文件**  
操作系统不一样/JDK/Tomcat版本不一样/代码引用本地路径/配置文件引用系统环境，这些都可能造成程序运行失败  
而docker做的是，将操作系统-JDK-Tomcat-代码-配置文件分别打包到集装箱，再迁移到另一台机器中隔离运行。这样无疑是成功的。  
**解决了运行环境不一致的问题**  

- 系统好卡啊，哪个哥们又写了死循环？！  
linux是多用户协作，有时候你什么都没做，应用就挂了，原因可能是你的协作者程序程序内存泄露/写死循环疯狂打日志把磁盘占满/死循环吃硬盘和CPU速度下降  
而docker做的是，在创建的时候就限定了该用户的内存磁盘空间，超过了就把你杀掉，不会影响其他人  
**docker的隔离性解决了多用户操作产生的干扰**  

- 双11来了，服务器快架不住了！  
对于电商服务器，每到节日的业务量是平时的几十倍，运维总在节日前扩展机器，节日后节点下线，这给运维带来极大的工作量  
docker要做的是，下载，安装，无需配置环境，整个过程大大节省了时间。  
**docker使服务器的快速扩展，弹性伸缩成为可能**  

综上，docker于我们的意义在于：  

**快速的持续集成，服务的弹性伸缩，部署简单，解放了运维。最重要的是，它为企业节省了机器资源**  

在 docker 出现之前，需要运维逐台服务器部署（装环境、更新 war 包等），缺点是:
- 部署非常慢，效率低
- 服务器资源浪费（一个服务器只装有一个环境和相应 war 包）
- 难于迁移和扩展
- 可能对服务器硬件产生依赖


# 二. docker 使用

## docker 安装
```bash
brew cask install docker
docker version
```

## docker 常用命令

## 一个简单的 hello-world 跑全程
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/hello-world.png)

如图，`docker pull`以后，本机先查看本地是否存在该镜像，若存在，不做操作；若不存在，默认从docker官网下载该镜像  
本例hello-world是一个静态网页，docker启动后。只运行一次

```bash
1. 下载镜像   docker pull hello-world  

2. 查看本机所有镜像   docker images  

3. 生成容器   docker run hello-world
```
## 一个简单的 nginx 跑全程
1. hello-world打印一行字后就自动退出了，nginx却是一个在后台持久运行的容器  
2. hello-world && 前台挂起    nginx && 后台运行   
3. 后台运行的容器，我们可以进入容器内部，观察它在后台是怎样运行的  
4. nginx可在前台运行，也可后台运行，多数情况下是在后台  

```angular2html
1. 拉镜像   docker pull hub.c.163.com/library/nginx:latest  

2. 前台运行   docker run hub.c.163.com/library/nginx  

3. 查看正在运行的容器   docker ps  

4. 停止前台运行    ctrl+c  

5. 后台运行    docker run -d hub.c.163.com/library/nginx  

6. 进入容器    docker exec -it 容器id bash

7. 查看容器位置   which nginx  

8. 查看容器中有哪些进程   ps -ef  

9. 退出容器   exit  

10. 关闭容器   docker stop 容器id
```


```
docker image prune
docker container prune
docker system prune

docker logs [containerID]
```

在使用nginx的时候，有一个问题我们不得不考虑一下，即**docker的网络**  
我们考虑docker网络，是因为我们想在本机浏览器中访问docker的80端口  

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/dockerNet.png)
1. Bridege：这是创建docker容器时默认的网络格式，Bridege模式让容器虚拟出自己的网卡和ip，我们要通过**端口映射**让主机访问容器的端口  
2. host：容器不会虚拟自己的ip和网卡，而是和主机共用一个网卡和ip  
3. none：容器不联网
下面是Bridege模式下对容器端口映射  
```angular2html
1. 主机8080端口对应容器80端口  
docker run -d -p 8080:80 nginx  

2.查看端口对应情况  
netstat -na|grep 8080

3. 浏览器访问  
localhost:8080
```
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/nginx8080.png)

## 制作自己的 javaWeb 镜像   - jpress

这次我要做的是一个wordpress镜像  

- 相关概念  
  - dockerfile  
告诉docker制作镜像每一步的命令  
  - docker build  
逐行执行dockerfile里的命令  
  - [jpress](http://jpress.io)  
jpress是开源的wordpress的java版本，也可以是其他javaweb项目  

- 开始
1. 下载jpress的[war包](https://github.com/JpressProjects/jpress/blob/master/wars/jpress-web-newest.war)

2. 下载基础镜像  
回想一下，一个javaweb应用，Tomcat肯定是基础镜像，此tomcat镜像中以包含了JDK，还有mysql  
`docker pull tomcat`  
`docker pull mysql`

3. 写署名  

4. 把自己的应用（jpress）放到tomcat/webapps目录下，怎么找tomcat路径？由[文档](https://hub.docker.com/_/tomcat/)可知  

5. build镜像并命名
`docker build -t jpressfdf:latest .`  
点号表示当前目录

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/jpressImage.png)


6. 运行自己的镜像
`docker run -d -p 8080:8080 tomcat`  

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/tomcatSuccess.png)


- 配置jpress
1. 先把mysql启动起来
`docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=jpress mysql`  

2. 查看端口对应情况  
`netstat -na|grep 3306`

3. 填写数据库连接信息
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/dockerMysql.png)

【注意】  
localhost要写本机ip--因为jpress运行在容器中，你填localhost它会找容器的localhost，而不是物理机的localhost  

4. 最后一步  
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/jpressConf.png)


5. 重启web容器
`docker restart a2`  
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/jpressSuccess.png)



【Dockerfile源文件】  
```
from tomcat

MAINTAINER fdf fan.easter@gmail.com

COPY jpress-web-newest.war /usr/local/tomcat/webapps
```

# 三. 容器编排
对容器的创建、调度、管理、运维进行管理的工具。比如一个系统中有成百上千个容器，就需要容器编排工具对容器进行统一管理，常用的容器编排工具：docker swarm 和 k8s。

# 参考 && 学习资源

- 社区  
[docker中文网-很全奥！](http://www.docker.org.cn/book/docker/what-is-docker-16.html)  
[常见技术问答录](https://blog.lab99.org/post/docker-2016-07-14-faq.html)  
[官方镜像库](http://hub.docker.com/)


- 牛博  
[螃蟹的个人博客](http://www.pangxie.space/)   
[有视频的博客阿，很吊](https://blog.lab99.org/)

- https://princeli.com/mac-os%E7%B3%BB%E7%BB%9F%E4%B8%8Bvagrant%E7%9A%84%E5%AE%89%E8%A3%85%E5%8F%8A%E4%BD%BF%E7%94%A8/
