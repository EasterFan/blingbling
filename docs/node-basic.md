# Node 基础

> 关于前端基本概念

## nvm、node、npm、npx 之间的关系和区别

- nvm：nodejs 版本管理工具。
也就是说：一个 nvm 可以管理很多 node 版本和 npm 版本。
这个技术出现的原因， 是由于不同的项目node版本也不同，有的是5.0.1， 有的是6.3.2。 如果node出现版本不对，运行 某个应用时，很可能就会遇到各种莫名其妙的问题 。

- nodejs：在项目开发时的所需要的代码库
npm：nodejs 包管理工具。
在安装的 nodejs 的时候，npm 也会跟着一起安装，它是包管理工具。

- npm 管理 nodejs 中的第三方插件。他的作用与Ruby中的 bundler及Java中的maven相同，都是对第三方依赖进行管理的。

- npx，是 npm 自带的命令，要求 npm > 5.6  

npm 和 npx 区别：  
相同点：  
- 从功能上看，两者都是为了安装依赖，即 js 代码库

不同点
- 从命名上看：npm 是node包 **管理** 工具，npx是 node 包 **执行** 工具
- 从结果上看：
  - npm：会直接把依赖下载到本地开发环境（node_modules）
  - npx：会先检测本地node_modules中是否有相关依赖,有则直接调用他的命令行（到 `node_modlues/.bin`）,没有的话回去上一级的node_modlues中寻找,直到找到系统的node_mudules中(最终找到系统环境变量 `$PATH`, 比如运行 `npx ls` ),如果还是没有找到,则会通过网络将相关依赖下载到电脑内存中,执行完相关代码,就会马上 **删除** 内存中的依赖
- 从设计目的上看：
  - npm 是为了项目开发
  - npx 为了在不侵入源代码的基础上，直接调用 `node_modlues`中依赖的 **命令行工具**

```bash
# npm 从前运行命令的方法：先安装，再运行 / 或者在 package.json 的 script 命令中 添加命令，然后使用 npm run xxx 运行
npm install some-package -g
./node_modules/.bin/some-package

# npx ：有则运行，无则先下载-再运行-运行结束后删除
npx some-package
```

三者的关系：  
![关系](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/20200229102215.png)
