

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
