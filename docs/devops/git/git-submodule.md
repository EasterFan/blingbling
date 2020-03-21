> git 的基本和进阶使用

# git submodule 管理子模块
> 大型项目往往有很多子模块，这些子模块有一些是公共的类库，并在单独的仓库中更新维护，然后提供给多个项目使用。但是这个 `library` 怎么和主项目在一起方便管理呢？ `git submodule` 就是一个允许 **库中库** 的多模块仓库管理工具。

我们需要解决下面几个问题：

- 如何在git项目中导入 `library库` ?

- `library库` 在其他的项目中被修改了可以更新到远程的代码库中?

- 其他项目如何获取到 `library库` 最新的提交?

- 如何在clone的时候能够自动导入`library库`?

git 的 Submodule 可以解决上面的问题。  

## 快速开始搭建一个多模块项目
以 hexo 博客导入 Landscape 主题仓库为例，快速初始化一个 hexo 博客  

```bash
# 初始化 hexo
npx hexo init hexostyle

# 在这一步就可以看到 themes 目录下的主题仓库是一个子仓库
Submodule path 'themes/landscape': checked out '73a23c51f8487cfcd7c6deec96ccc7543960d350'

# 启动 hexo
cd hexostyle && npx hexo s
```

## 新添加子模块
子模块添加到的文件夹需要为空~

```bash
cd hexostyle
git submodule add https://github.com/DukeLuo/hexo-theme-candelas.git themes/candelas
git commit -m "add submodule version 1.0"
```
添加完成后，可以看到主项目多了一个 `.gitmodules` 文件。

## 从已有的文件创建 git 子模块
大多数时候，git 子模块不是凭空创建的，而是从项目中已有的文件拆分出来的。从已有的文件创建 git 子模块需要做三件事：首先为拆分出来的文件创建新的 git 仓库，然后从主仓库中将独立出去的文件移除，最后再注册 git 子模块。  

但是这种方法带来的问题是，添加子模块后，checkout 进行版本的回退会非常的麻烦，需要在子模块内部 reset 或者将子模块卸载掉（这也可能是项目中尽量避免使用 git 子模块的原因吧~）

## 向上同步主仓库
如果你是子模块的开发者，当你希望主仓库使用新版本的子模块时，需要向上同步主仓库。

在主仓库中，可以使用 git submodule status 和 git status 查看子模块的状态。

## 向下同步子仓库
如果你是主仓库的开发者，你可能不想使用最新版本的子模块，而是使用主仓库中指定版本的子模块，此时可以使用下面的指令：

```bash
git submodule update
```
## 删除子仓库
git 并不支持直接删除Submodule需要手动删除对应的文件。  
```bash
# 手动删除子模块
cd hexostyle
git rm --cached candelas
rm -rf candelas
rm .gitmodules

# 删除主项目的 config 中和 submodule 相关的节点信息
vim ~/.git/config
git commit -m 'remove candelas submodule'
```



# 参考
- https://bitmingw.com/2018/08/19/git-submodule-tutorial/
