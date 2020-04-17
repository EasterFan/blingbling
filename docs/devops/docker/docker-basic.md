


# 一. docker 介绍

## docker 是什么
1. docker是一个可以装应用的程序，就像杯子装水一样，可以把hello-world、网站，任何你想到的程序放进docker。  
2. 它将linux容器中的应用代码打包，可以轻松的在服务器之间进行迁移。

## docker 关键字


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

## docker 三大核心概念

## docker 于我们的意义


# 二. docker 使用

## docker 安装

## docker 常用命令

## 制作自己的 javaWeb 镜像   - jpress



# 参考
