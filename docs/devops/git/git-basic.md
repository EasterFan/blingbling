> git 基本操作

<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [了解 Git](#了解-git)
  - [版本控制](#版本控制)
  - [Git存储方式](#git存储方式)
  - [图解Git工作原理](#图解git工作原理)
  - [Git四个协议](#git四个协议)
  - [SSH密钥配置](#ssh密钥配置)
- [Git 工具](#git-工具)
  - [GitBash配置](#gitbash配置)
  - [GUI下载配置](#gui下载配置)
  - [sourcetree](#sourcetree)
  - [EGit](#egit)
- [Git 简单配置](#git-简单配置)
  - [配置Git参数](#配置git参数)
  - [ignore](#ignore)
  - [换行](#换行)
  - [别名](#别名)
  - [凭证](#凭证)
- [Git 常用基础命令](#git-常用基础命令)
  - [新建仓库init](#新建仓库init)
  - [删除文件clean](#删除文件clean)
  - [添加文件add](#添加文件add)
  - [代码提交commit](#代码提交commit)
  - [查看信息hi](#查看信息hi)
    - [仓库当前信息](#仓库当前信息)
    - [查看commit - 仓库的commit历史](#查看commit---仓库的commit历史)
    - [查看commit - 文件的commit历史](#查看commit---文件的commit历史)
    - [查看单个文件在三个状态下的改变diff](#查看单个文件在三个状态下的改变diff)
  - [同步远程仓库](#同步远程仓库)
  - [回撤reset](#回撤reset)
- [Git 标签](#git-标签)
  - [添加标签](#添加标签)
  - [删除标签](#删除标签)
  - [推送标签](#推送标签)
- [Git 分支](#git-分支)
  - [分支简介](#分支简介)
  - [冲突解决](#冲突解决)
  - [分支命令](#分支命令)
- [Git 团队协作](#git-团队协作)
  - [Forking工作流](#forking工作流)
  - [GitFlow 工作流](#gitflow-工作流)
  - [功能分支工作流](#功能分支工作流)
  - [集中式工作流](#集中式工作流)
- [Git 小工具](#git-小工具)
  - [git-it](#git-it)
  - [try git](#try-git)
<!-- TOC END -->

# 了解 Git
## 版本控制
版本控制有三个发展阶段：本地版本控制、集中版本控制、**分布版本控制**
- 本地版本控制  
缺点：适合个人用户，不同操作系统的人无法操作它。不适合团队协作。
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/bendi.png)


- 集中版本控制
缺点：可以团队协作，所有人在客户端将代码交给一台服务器汇总，服务器宕机，数据丢失，怕不怕？
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/jizhong.png)


- 分布版本控制
优点：省磁盘空间；它是分布的。  
代表：Github、码云等
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/fenbu.png)



## Git存储方式
- 普通CVS存储方式  
普通CVS：存储的是**变更**。若想得到最终版本，则从第一个版本开始，累加所有变更△n
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/ccfs1.png)

- Git存储方式  
1. Git存储的是**快照**和**指针**。每一次提交后，变化了的文件存储的是快照，没变化的文件存储该文件的指针（如虚线框）  
2. Git存储的快照采用zip压缩格式；当更改部分特别小时，采用打包文件方式，只保存变更信息（此处同CVS）
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/ccfs2.png)



## 图解Git工作原理
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/yuanli1.png)
- 三个区域  
**工作区**：eclipse等环境，代码加工厂    
**暂存区-Stage**：存放下次要提交的文件，stage设置的目的是为了合理地控制回退  
**.git**：存放历史操作，回退用到  
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/yuanli2.png)

- 四个状态  
**暂存区**：stage  
**仓库**：unmodified  
**工作区**：untrackted 未放入暂存区的文件  
modified——已放入暂存区，但做了修改的文件
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/yuanli3.png)



## Git四个协议

|    协议      | 作用    |  优点   |  缺点   |  命令    |
|----------|-------|-----|-----|------|
|  **本地协议**   |  团队中每一位成员对一个共享的文件系统（如NFS）拥有访问权，此时的远程仓库就是硬盘上的一个目录   |架设简单，适合局域网团队合作  | 1.局域网中仓库互联网无法访问，比如在家不能访问公司仓库  2.不建议使用file协议中转，速度很慢    | ![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/xieyi1.png) |
|  **Git协议 **   | 如果你在提供一个**有很大访问量**的公共项目，或者一个不需要对读操作进行授权的**庞大项目**，架设一个 Git 守护进程来供应仓库是个不错的选择    | 1. 现存的传输最快的协议  2.它使用与 SSH 协议相同的数据传输机制，但省去了加密和授权的开销。效率高。   |  1.缺少授权机制。除了管理员有写权限，其他人都是只读权限--故Git协议总是与SSH/HTTP协议配合使用  2.架设较难（相比http）  3.采用9418端口，大多数企业封锁这个不常用端口，导致Git协议无法使用   |
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/xieyi2.png) |
|   **http协议 ** |  入门级   |  简单，架设方便   |  速度慢（相比SSH）   | ![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/xieyi3.png) |
|  **SSH协议  **  | SSH 是唯一一个同时支持读写操作的网络协议，（HTTP 和 Git）通常都是只读的，执行写操作时还是需要 SSH  |  1.具有写的权限  2.传输之间压缩数据（同本地协议、Git协议）   |  SSH 的限制在于你不能通过它实现仓库的匿名访问。即使仅为读取数据，人们也必须在能通过 SSH 访问主机的前提下才能访问仓库，这使得 SSH 不利于开源的项目。如果你仅仅在公司网络里使用，SSH 可能是你唯一需要使用的协议。如果想允许对项目的匿名只读访问，那么除了为自己推送而架设 SSH 协议之外，还需要支持其他协议以便他人访问读取。   |
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/xieyi4.png) |


## SSH密钥配置

- 生成 RSA 密钥对  
一直Enter，记住密钥对保存位置`C:\Users\Administrator\.ssh`，可以将这两个私钥和公钥打包保存到百度云---这样重装系统后SSH不会失效

```
    ssh-Keygen -t rsa -C "fan.easter@gmail.com"
```
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/SSHKey1.png)

- 复制id_rsa公钥  
先`cd ~`到主目录下
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/SSHKey2.png)

- 在 Github 网站添加公钥
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/SSHKey3.png)

- 添加成功  
第一次没使用SSH时，钥匙是黑色的，连接后变绿
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/SSHKey4.png)

- 使用 SSH 协议，克隆仓库或者添加远程链接
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/SSHKey5.png)

- 连接成功，钥匙变绿
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/SSHKey6.png)


# Git 工具
## GitBash配置
- 下载[Git](https://git-scm.com/)   
`git -version` 测试安装是否成功
![download](github_imgs/download.png "官网下载")

- 配置Bash环境
  - 鼠标改成绿色，块状，不闪  
![config](github_imgs/config.png "鼠标")  
  - 字体大小  
![font](github_imgs/font.png "字体变大")  
  - 使bash能输入中文
![chinese](github_imgs/chinese.png "中文输入")

## GUI下载配置  
**中文乱码**：在GUI空白处右键编码，选择utf-8

## sourcetree
界面精致，用于以后的分支操作

## EGit
- 安装
EGit是eclipse IDE的插件  
```
工具----插件安装-----EGit
```
- 导入文件
![导入](github_imgs/EGit1.png "导入")
![导入](github_imgs/EGit2.png "导入")
![导入](github_imgs/EGit3.png "导入")
![导入](github_imgs/EGit4.png "导入")
![导入](github_imgs/EGit5.png "导入")

- 提交文件  
在仓库名或文件内部`右键---Team`进行add、commit、push、pull操作

# Git 简单配置

## 配置Git参数
- 显示当前的 Git 配置
```
    git config --list
```
- 设置提交仓库时的用户名信息
```
    git config --global user.name “EasterFan”
```
- 设置提交仓库时的邮箱信息
```
    git config --global user.email “fan.easter@gmail.com”
```

## ignore
IDE创建项目会自动创建一些文件（如hbuilder创建.project），这类文件不需要push到github，放入一个gitignore文件，告诉git这些文件不需push（gitignore是txt文件，要add到版本控制中）  

- 使用场合
```
  1. 忽略操作系统自动生成的文件，比如：缩略图，等；
  2. 忽略编译生成的中间文件、可执行文件等，比如： C 语言编译产生的 .obj 文件和 .exe 文件；
  3. 忽略你自己的带有敏感信息的配置文件，比如：存放口令的配置文件；
  4. tmp/ 临时目录；
  5. log/ 日志目录；
```

- ignore 模板
  - 自己创建gitignore`vim .gitignore`
  - 创建仓库时选择自动创建ignore，[官网](https://github.com/github/gitignore)查看所有语言的ignore模板
  - ignore文件中`#`表示`注释`，每一行代表这一类文件被ignore

- 两个命令
  - 强制添加 .gitignore 忽略的文件  
`git add –f <file name>`

  - 查看 .gitignore 策略生效行号  
`git check-ignore –v <file name>`


## 换行
Windows下执行`git add`时，总是报下面的警告，Linux系统下不会报。
![warning](github_imgs/huanhang1.png "换行")   
执行这行代码  
```
 提交时转换为LF，检出时转换为CRLF，默认设置不用修改，Git 是 linux 配置
git config –-global core.autocrlf true
允许提交包含混合换行符的文件
git config –-global core.safecrlf false
```

## 别名
- 为commit设置别名  
`git config –-global alias.ci commit`
- 为长命令设置别名，查看历史
```
git config –-global alias.hi log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
```

- 为`git status -sb`设置别名，使查看状态时更简洁
`git config –-global alias.st status -sb`
建议直接`cd ~`到主目录后`vim .gitconfig`直接修改配置文件
![别名](github_imgs/bieming1.png "别名")

## 凭证
使用HTTPS推送push要求输入用户名密码，用下面这行代码保存用户名密码，不用每次push都输。
```
git config –-global credential.helper wincred
```
这行代码在仓库目录下运行，再`cd ~`到主目录，`vim .gitconfig`查看配置信息
![凭证](github_imgs/pingzheng1.png "凭证")
使用SSH协议不必这样设置。

# Git 常用基础命令

## 新建仓库init
新建仓库有两种：自己创建和克隆别人
- 在当前目录新建一个 Git 代码库  
    `git init`

- 下载一个项目和它的整个代码历史  
    `url 格式: https://github.com/[userName]/reposName`  
    `git clone [url]`

## 删除文件clean
删除未被跟踪的文件---还没有add的文件
- 列出打算清除的档案
    git clean -n

- 真正的删除
    git clean –f

- 连 .gitignore 中忽略的档案也清除
    git clean -x


## 添加文件add  

add跟踪对文件的各种操作（删除、编辑、改名、移动），方便回撤  

- 跟踪添加文件
    ```
    git add [file]  
    git add .
    ```

- 跟踪删除文件  
    ```
    git rm [file1]  
    git st  
    git ci -m "delete file1"
    ```

- 跟踪编辑文件  
```
echo 111 >> a
git st  
git ci -m "update file a"
```

- 跟踪改名文件
```
git mv [file-origin] [file-renamed]
git st  
git ci -m "rename file-origin to file-renamed"
```

- git add -p file 一个文件多次提交  
一个文件中对多处代码修改，将这几个修改分不同次提交----方便回撤
分割更新文件S
![add](github_imgs/add1.png "add")

将需要一起add的代码选为Y
![add](github_imgs/add2.png "add")

`git diff`查看是否正确分组
![add](github_imgs/add3.png "add")

分两次commit  
![add](github_imgs/add4.png "add")


## 代码提交commit

- 提交暂存区到仓库  
    `git commit –m [message]`

- 直接从工作区提交到仓库
 前提该文件已经有仓库中的历史版本  
    `git commit –am [message]`

- commit编写规范
![commit](github_imgs/commit.png "commit")
更多内容参考[阮一峰博客---commit规范](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)


##  查看信息hi  
### 仓库当前信息
    `git status`  
    `git status -sb`简短地显示

### 查看commit - 仓库的commit历史
  1. 查看最近5次commit  
  ```
  git hi -5    首选
  git log --oneline  不显示commit时间
  gitk   图形查看，更直观，无哈希值
  git log 不推荐，又杂又乱
  ```

  2. 查看特定commit的详细信息

  ```
  git show HEAD   最后一次commit详细信息  
  git show HEAD~2 倒数第三个commit详细信息
  git show [RspoHashValue]
  ```   

   3.过滤仓库commit历史  
  `git log --grep <msg>`  
  `git hi --grep add`只查看commit中含有add的提交


### 查看commit - 文件的commit历史

  ```
  git blame README.md   blame比hi详细一点
  git hi README.md
  git show [FileHashValue]
  ```

### 查看单个文件在三个状态下的改变diff  
提交前要查看一下差异
![diff](github_imgs/diff.png "一图解千言")

## 同步远程仓库
- 查看是否存在远程连接  
    `git remote -v`
- 增加/删除远程仓库，并命名  
```
    git remote add [shortname] [url]
    git remote add origin https://github.com/Eas/Trygit.git
    git remote rm origin
```

- 将本地的提交推送到远程仓库  
```
    git push [remote] [branch]
    git push origin master
```

- 将远程仓库的提交拉下到本地  

```
    git pull [remote] [branch]
    git pull origin master
```

## 回撤reset  
- 回撤的目的
  1. 更改commit的Message
  2. 将10次提交合并成3次提交
  3. 将3次提交拆分成10次提交  
- 注意事项
  1. 回撤以后哈希值改变
  2. 可以回撤一个回撤，只要commit后，产生哈希值，就可回撤到这个状态
  3. 回撤远程仓库会弄乱别人的本地仓库  

- 三个状态下的回撤
![reset](github_imgs/reset.png "reset")

- 用这一次提交覆盖上一次提交  
```
	git add .
	git commit --amend –m “message”
```
- 变基操作，回撤上n次提交  ---> 历史是一个任人打扮的小姑娘  
```
	git rebase –i HEAD~3
```

# Git 标签

## 添加标签
```bash
#当前提交添加标签：
	git tag v1.0

#历史提交添加标签：
	 git tag v2.0 哈希值

#给标签添加注释:
	git tag v3.0 –m “message”

#在当前提交之前4个版本上，打标签v4.0：
	git tag v4.0 HEAD~4

#查看所有标签：
	git tag
```

## 删除标签
```bash
#删除本地标签：
	git tag –d v1.0

#删除远程标签：
	git push origin :refs/tags/v1.0

```
## 推送标签
```bash

#推送多个
	git push origin --tags

#推送一个
	git push origin v0.1

```

# Git 分支

## 分支简介
- Git分支  
![branch1](github_imgs/branch1.png "branch1")
- Gitflow工作流  
![branch2](github_imgs/branch2.png "branch2")

## 冲突解决
- 冲突发生的原因  

1. 在不同分支上，修改同一个文件；
2. 不同的人，修改了同一个文件--本地和远程修改同一个文件；  
3. 不同的仓库，修改了同一个文件--电脑C盘、D盘修改同一文件；  
4. 冲突只在合并分支的时候才会发生--不合并的时候在潜伏；


- 冲突的解决方法  
1. 发生冲突并不可怕，冲突的代码不会丢失；
2. 解决冲突，编辑冲突文件，重新提交，commit 时不要给 message；
3. 冲突信息的格式；

## 分支命令

# Git 团队协作
## Forking工作流
开源世界的主流玩法  

## GitFlow 工作流


## 功能分支工作流


## 集中式工作流


# Git 小工具
## git-it
- [下载](https://nodejs.org/en/) nodeJS  
![nodeJS](github_imgs/nodeJS.png "下载")
- 在cmd下安装git-it  
    npm install git-it -g

- 游戏关卡汉化
将此中文文档在浏览器中打开
![汉化界面](github_imgs/gitit.png "浏览器打开")
- 新建一个文件夹做仓库
在cmd中进入此文件夹，运行`git-it verify`,pass即通关

## [try git](https://try.github.io/levels/1/challenges/1)
