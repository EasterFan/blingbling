<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [一. docker-compose 是什么](#一-docker-compose-是什么)
  - [docker-compose 组成](#docker-compose-组成)
    - [Service](#service)
  - [docker-compose 水平扩展和负载均衡](#docker-compose-水平扩展和负载均衡)
    - [水平扩展](#水平扩展)
    - [负载均衡](#负载均衡)
<!-- TOC END -->

# 一. docker-compose 是什么
docker-compose 是 docker 的命令行工具，用于管理多个容器的启动，停止和删除，比如 docker 搭建 wordpress，需要同时管理三个容器（wordpress，mysql），docker-compose 的作用相当于一个容器的批处理脚本，用于简化多容器的管理。

> 推荐使用 docker-compose version 3 - version 3 可以将容器部署到多个服务器，version 2 只能部署到单机

## docker-compose 组成
docker-compose.yml 文件主要由三部分组成：Service、Networks、Volumes

### Service
- 一个 Service 代表一个 Container
- service 的启动类似 `docker run`,我们可以给其指定 network 和 volume，也可以给 service 指定 network 和 volume 的引用

下面是 wordpress 的 docker-compose：
```bash
      version: '3'

      services:

        wordpress:
          image: wordpress  # 从 docker hub 上拉取，或者指定 dockerfile 路径
          ports:
            - 8080:80
          depends_on:
            - mysql
          environment:
            WORDPRESS_DB_HOST: mysql
            WORDPRESS_DB_PASSWORD: root
          networks:
            - my-bridge

        mysql:
          image: mysql:5.7
          environment:    # 相当于 -e 参数传递环境变量
            MYSQL_ROOT_PASSWORD: root
            MYSQL_DATABASE: wordpress
          volumes:
            - mysql-data:/var/lib/mysql
          networks:
            - my-bridge

      volumes:
        mysql-data:

      networks:
        my-bridge:
          driver: bridge
```

## docker-compose 水平扩展和负载均衡
> 1 对 1 是端口映射，1对多是负载均衡，水平扩展多个容器之后，就要考虑怎样把请求均匀的转发给每个容器，这就是负载均衡的范畴

### 水平扩展
是指在根据同一个镜像，在同一台机器上部署多个相同的 container 容器。
```bash
# wordpress 是 yml 文件中的 service 名
docker-compose up --scale wordpress=10 -d
```
- 使用 scale 水平扩展多个容器时，要注意多个容器之间的端口冲突（多个容器都将端口映射到本机同一个端口会造成冲突）。解决方法是到 `docker-compose.yml` 文件中删除端口映射的命令（ports:8000:80）

### 负载均衡
上面为了避免端口冲突，直接在 docker-compose.yml 文件里删除了（ports:8000:80），如果仍然想对一群容器做端口映射的话，就需要借用 haproxy 做端口映射，即负载均衡。
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200609104520.png)
