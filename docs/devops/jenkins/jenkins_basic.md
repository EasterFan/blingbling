<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [搭建 jenkins](#搭建-jenkins)
- [Master-slave 模式](#master-slave-模式)
  - [docker 安装 jenkins](#docker-安装-jenkins)
  - [安装插件:](#安装插件)
- [搭建一个 maven 项目](#搭建一个-maven-项目)
  - [基础配置](#基础配置)
  - [权限管理](#权限管理)
  - [参数化构建](#参数化构建)
  - [Pipline 流水线](#pipline-流水线)
    - [1. Pipline 介绍](#1-pipline-介绍)
    - [2. Pipline 常规构建](#2-pipline-常规构建)
    - [3. Pipline + Docker 自动化构建](#3-pipline--docker-自动化构建)
  - [参考](#参考)
<!-- TOC END -->



# 搭建 jenkins


# Master-slave 模式
如果只有一台装了 jenkins 的服务器时，
有很多的IO，排列到队列中等待，比如 java 构建，测试，时间特别长
jenkins 本身的负载特别大
在高并发环境下，解决 jenkins 单点性能的不足
jenkins 的 Master-slave 模式就是为了解决这个问题，将任务分发给别的服务器去实现，从而减轻 jenkins 负载

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200827103304.png)

在 slave 上打包成功后，可以推送到远程，也可以在 slave 本地发布。


## docker 安装 jenkins
```bash
# 安装官方推荐镜像
docker pull jenkinsci/blueocean

# 新建 jenkins_home 数据存储路径 - 并设置为 jenkins 可访问
mkdir -p ~/my_jenkins/jenkins_home &&  sudo chown -R 1000:1000 ~/my_jenkins/jenkins_home/

# 启动镜像 - 云服务器启动记得打开对应防火墙端口
docker run -d --name=my_jenkins -p 8089:8080 -p 50001:50000 -v ~/my_jenkins/jenkins_home:/var/jenkins_home 5b5549c2d6c8

# 查看 jenkins 对应的管理员密码 - 可以直接 docker logs 查看
docker exec -it 6847500d1883 cat /var/jenkins_home/secrets/initialAdminPassword
```
过程可能出现“无法连接到 jenkins” 的问题，网络原因，只能多试几次
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200709101951.png)

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200709143635.png)

## 安装插件:
- safe restart
- rebuilder - 重新构建
- Maven Integration
- Role-based Authorization Strategy - 角色管理插件
- Extended Choice Parameter && Git Parameter - 参数化构建
- pipeline - 必备流水线！
- build monitor view - 可视化！


# 搭建一个 maven 项目
新建一个 maven 任务 - 如果没有这个选项的话需要安装 Maven Integration 插件。  
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200723114456.png)




## 基础配置

- 丢弃旧的构建 - 保留最近几次构建，节省磁盘空间

## 权限管理
> 一个 jenkins 很多角色在用，比如 开发、运维、测试，所以需要权限管理 - 使用 Role-based Authorization Strategy 插件

1. 打开注册权限： 全局安全配置 -> 安全域 -> 允许用户注册（默认注册用户有和 admin 同样的权限）
2. 启用 Role-based Authorization Strategy 授权策略 :全局安全配置 -> 授权策略 -> Role-based Strategy

插件启用成功后，会发现原来注册的用户没有了权限  
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200729153029.png)
3. 创建用户组
在系统管理 -> Manage and Assign Roles 处设置
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/Snipaste_2020-07-29_15-52-32.png)

4. 将用户加入用户组 - 配置完后如果权限不对，重启 jenkins
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/2020-07-29_16-03-0423.png)

5. 通过小加号对多项目进行简单划分
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200729162626.png)

## 参数化构建
> 用户在构建时可以交互的输入自己的参数。 - 使用 Extended Choice Parameter

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/2020-07-29_16-4956-20.png)

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/2020-07-29_16-5458-42.png)

如果使用 property 文件的话，需要在 jenkins_home 里新建一个文件：
touch jenkins.property
```bash
branch=test01,test02,test03
```
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200729170421.png)

Git 插件 - 直接获取到 Git 的各种信息-版本号、tag等
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200729170903.png)

## Pipline 流水线
> Pipline 是当下 CICD 最佳实践

### 1. Pipline 介绍

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/Snipaste_2020-08-12_19-45-55.png)


### 2. Pipline 常规构建
1. 新建 pipeline 流水线
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200729181121.png)

2. 设置从 Git 仓库里拉取 jenkinsfile
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200729181339.png)

```bash
node () {
   //def mvnHome = '/usr/local/maven'
   stage('git checkout') {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '9991b831-718c-485f-9699-53941d9d855e', url: 'https://code.aliyun.com/zhejiangsaimo/LargeVisualScreen.git']]])
   }
   stage('maven build') {
        echo 'build...'
   }
   stage('deploy') {
        echo 'deploy...'
   }
   stage('test') {
      echo 'test...'
   }
}
```

### 3. Pipline + Docker 自动化构建
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200812194059.png)


## 参考
- jenkins 书中文版
https://www.jenkins.io/doc/book/pipeline/jenkinsfile/#creating-a-jenkinsfile
- 一个比较好的示例
https://github.com/showerlee/java-war-dev
