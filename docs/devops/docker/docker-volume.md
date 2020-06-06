
# Docker 持久化存储和数据共享
## 为什么持久化存储？
docker 从镜像中启动容器（`docker run imageID`），实际上是在镜像上层新建了一层，并且对容器进行数据写操作时，镜像不会改变，容器数据会改变，但是当容器关闭时，更改的数据也会消失，为了将这些数据永久保存到本地，引出了 docker 持久化的话题。

docker 持久化的解决方案通常有两种：  
- 基于本地文件系统的 Volume：在执行 `docker create` 或 `docker run` 时，通过 -v 参数将主机目录作为容器数据卷。
- 基于 plugin 的 Volume：将容器数据保存到第三方云存储，比如 NAS， AWS

容器数据卷类型有两种：  
- Data Volume：受管理的 data Volume，由 docker 后台自动创建 - 通过 Dockerfile 指定
- bind Mounting：绑定挂载的 Volume，具体挂载位置可以由用户指定 - 映射关系，双向同步

## Data Volume
在 dockerfile 中使用了 volume 命令后，docker 会自动创建数据卷并保存到本地。

```bash
# 修改默认 volume name（太长）
docker run -d -v new_volume_name:/var/lib/mysql --name mysql mysql5.7

# 查看所有volume
docker volume ls

# 删除指定volume
docker volume rm [volume name]

# 查看volume详细
docker volume inspect [volume name]

# 使用一个 volume - 用这个名为 new_volume_name 的 volume 作为一个新容器的数据卷
docker run -d -v new_volume_name:/var/lib/mysql --name mysql2 mysql5.7
```

## Bind Mounting
和 Data Volume不同的是，bind Mounting 只能通过 `docker run -v` 方式启动，无法使用 dockerfile 文件的方式。

运行容器的时候指定本地的一个文件目录和容器中的一个文件目录的映射，通过这个可以做文件数据同步，两方无论哪一方有修改，另一方都会同步内容

```bash
# 将当前目录作为数据卷挂载到 /usr/share/nginx/html 目录下
docker run -d -v $(pwd):/usr/share/nginx/html -p 80:80 --name nginx nginx
```

值得注意的是，使用bind Mounting方式做数据卷的映射时，首次docker run -v 运行，如果本机的文件夹是没有内容的，docker容器中的文件夹是有内容的，则本机的会覆盖dokcer容器中的，也就是容器中原本有内容的也会没有内容。

Bind Mounting 最有用的地方是在开发环境中，将源码挂载到 docker 中，可以实时预览，就不用每做一次改动，就打一个镜像了。
