
# 搭建 jenkins

## docker 安装 jenkins

### 修改权限

chown user:group file


```bash
# 安装官方推荐镜像
docker pull jenkinsci/blueocean

docker run -d --name=saimo_jenkins -p 8081:8080 -v /saimo_data/jenkins_home:/var/jenkins_home 60f81923d099

# 启动镜像
docker run -d --name saimo_jenkins -p 8081:8080 -p 50001:50000 b2e3a5384a86
```

```
docker exec -it 6847500d1883 bash
cat /var/jenkins_home/secrets/initialAdminPassword
```
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200709101951.png)

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200709143635.png)

## 安装插件:
- safe restart
- rebuilder - 重新构建



## 基础配置
- 安全矩阵
- 新建用户 - 系统管理- 用户管理
