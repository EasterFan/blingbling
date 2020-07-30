
# 搭建 jenkins

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
