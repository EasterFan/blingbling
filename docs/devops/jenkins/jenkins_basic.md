
# 搭建 jenkins

## docker 安装 jenkins

```bash
# 安装官方推荐镜像
docker pull jenkinsci/blueocean

# 新建 jenkins_home 数据存储路径 - 并设置为 jenkins 可访问
mkdir -p /my_jenkins/jenkins_home &&  sudo chown -R 1000:1000 /my_jenkins/jenkins_home/

docker run -d --name=saimo_jenkins -p 8081:8080 -p 50001:50000 -v /my_jenkins/jenkins_home:/var/jenkins_home 60f81923d099

# 启动镜像 - 云服务器启动记得打开对应防火墙端口

docker run -d --name saimo_jenkins -p 8081:8080 -p 50001:50000 b2e3a5384a86

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


# 搭建一个 maven 项目
新建一个 maven 任务 - 如果没有这个选项的话需要安装 Maven Integration 插件。  
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200723114456.png)


## 基础配置
- 安全矩阵
- 新建用户 - 系统管理- 用户管理
