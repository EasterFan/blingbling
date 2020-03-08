# Node 基础

> 关于前端基本概念

## nvm、node、npm之间的关系和区别

- nvm：nodejs 版本管理工具。
也就是说：一个 nvm 可以管理很多 node 版本和 npm 版本。
这个技术出现的原因， 是由于不同的项目node版本也不同，有的是5.0.1， 有的是6.3.2。 如果node出现版本不对，运行 某个应用时，很可能就会遇到各种莫名其妙的问题 。

- nodejs：在项目开发时的所需要的代码库
npm：nodejs 包管理工具。
在安装的 nodejs 的时候，npm 也会跟着一起安装，它是包管理工具。

- npm 管理 nodejs 中的第三方插件。他的作用与Ruby中的 bundler及Java中的maven相同，都是对第三方依赖进行管理的。

三者的关系：  
![关系](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/20200229102215.png)
