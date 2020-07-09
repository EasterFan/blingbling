
# 搭建 jenkins

`docker run -d --name=saimo_jenkins -p 8081:8080 -v /saimo_data/jenkins_home:/var/jenkins_home 60f81923d099`

```
docker exec -it 6847500d1883 bash
cat /var/jenkins_home/secrets/initialAdminPassword
```
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200709101951.png)

安装插件:
