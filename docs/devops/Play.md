# 自己玩一个在线应用


# 环境初始化
## 创建服务器
DO 上快速创建一个 docker droplet  
https://marketplace.digitalocean.com/apps/docker

## 配置 jenkins
```bash
# 启动 jenkins
docker run -d --restart=always --name=my_jenkins -p 8089:8080  -p 50001:50000 -v /root/easter/data/jenkins_home:/var/jenkins_home --user root --privileged -v /var/run/docker.sock:/var/run/docker.sock  a1a26454c4cd
```
 暂存
```bash
docker run -d --restart=always --name=my_jenkins -p 8089:8080  -p 50001:50000 -v /root/easter/data/jenkins_home:/var/jenkins_home --user root --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker-compose:/usr/local/bin/docker-compose a1a26454c4cd
```

--user 指定 jenkins 为 root，防止出现在 jenkins 中执行docker 命令时，出现权限不足情况
--privileged 将宿主机docker sock 挂载到容器中，使jenkins可以启动另一个容器
https://stackoverflow.com/questions/55055488/jenkins-in-docker-cannot-connect-to-the-docker-daemon-at-unix-var-run-docke

jenkins 中使用docker

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20201213185643.png)

## 备份 jenkins



## 踩坑
使用 `mvn package -X` 导致jenkins 疯狂打log，服务器CPU 和硬盘 IO 挂，最后导致 jenkins 重启，参照
https://stackoverflow.com/questions/24989653/jenkins-maven-build-137-error#:~:text=For%20reference%20the%20status%20code,OS%20needs%20more%20virtual%20memory.
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20201210172750.png)
