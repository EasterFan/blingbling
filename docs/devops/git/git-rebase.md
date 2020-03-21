> git rebase 合并多个 commit

# 变基前后的 commit 情况
变基前的 commit：  

commitID 为 `6a6ddd9` 到 `2b3fbee` 的 5 个提交

```bash
*   2b3fbee 2020-03-21 | Merge branch 'master' of https://github.com/DukeLuo/hexo-theme-candelas (HEAD -> master, origin/master, origin/HEAD) [EasterFan]
|\  l
| *   7302024 2020-03-21 | Merge branch 'master' of https://github.com/DukeLuo/hexo-theme-candelas [EasterFan]
| |\  
| | * 882c69f 2020-03-20 | change posts picture [EasterFan]
| | * a05062c 2020-03-20 | fix: hide banner when is not home page [duke]
| | * 6d6d9e6 2020-03-19 | problem [EasterFan]
| | * c433f77 2020-03-19 | delete picture in all article page [EasterFan]
| * | 9dbc8eb 2020-03-19 | delete picture in all article page [EasterFan]
| |/  
* / 6a6ddd9 2020-03-19 | [merge 2 commit]:delete picture in all article page [EasterFan]
|/  
* 6745f13 2019-12-31 | feat: remove useless languages [duke]
```

变基后的 commit：  
```bash
* 9ec9e27 2020-03-19 | [merge 22 commit]:delete picture in all article page (HEAD -> master, origin/master, origin/HEAD) [EasterFan]
* 6745f13 2019-12-31 | feat: remove useless languages [duke]
* edf2170 2019-12-31 | chore: modify gitignore [duke]
* 9a3540c 2019-12-30 | chore: rename package name [duke]
* 26f81d9 2019-10-30 | fix(seo): use valid schema and add microformat (#148) [curbengh]
*   0ad74d5 2019-09-15 | Merge pull request #150 from curbengh/jsdelivr-valine [curbengh]
|\  
| * f819ca7 2019-09-14 | fix: remove leancloud and specify version [curbengh]
| * 0256a05 2019-09-14 | feat: load valine from jsdelivr cdn [curbengh]
* |   214dad2 2019-09-15 | Merge pull request #151 from curbengh/libs-https [curbengh]
```

`git rebase -i 6a6ddd9`
`git rebase -i HEAD~5`

即合并不包括 `6a6ddd9` 在内的 5 个提交（可以把这个 hash 当成一个参照坐标），将这 5 个提交合并成一个具有新 hash 值的新提交。

变基后的合并操作：  
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/20200321094453.png)  

修改后保存退出，`git log` 查看 commit 已经合并，但是用 `git status` 查看后会提示用 `git pull` 命令更新（千万别 pull，不然就白rebase了），这时候需要 `git push -f` 强制 push 上去，执行前要保证强制 push 不要覆盖了别人的代码。  

变基操作最好是在本地变基，不要对远程仓库变基（强制 push 有覆盖别人代码的风险~）
