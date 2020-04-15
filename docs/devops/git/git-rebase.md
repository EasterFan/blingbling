> git rebase 合并多个 commit

# 变基前后的 commit 情况
目标： commitID 为 `5af54ad` 到 `2d0a1d1` 的 5 个提交合并成一个提交，即将这 5 个提交合并成一个具有新 hash 值的新提交。

变基前的 commit：  

![](https://raw.githubusercontent.com/easterfan/picgo/master/blingbling/2020/20200413220232.png)


变基后的 commit：  

![](https://raw.githubusercontent.com/easterfan/picgo/master/blingbling/2020/20200413220936.png)

![](https://raw.githubusercontent.com/easterfan/picgo/master/blingbling/2020/20200413221257.png)

`git rebase -i HEAD~5`

变基后的合并操作：  
![](https://raw.githubusercontent.com/easterfan/picgo/master/blingbling/2020/20200413222122.png)  

变基前后对比：
![](https://raw.githubusercontent.com/easterfan/picgo/master/blingbling/2020/20200413222506.png)

修改后保存退出，`git log` 查看 commit 已经合并，但是用 `git status` 查看后会提示用 `git pull` 命令更新（千万别 pull，不然就白rebase了），这时候需要 `git push -f` 强制 push 上去，执行前要保证强制 push 不要覆盖了别人的代码。  

变基操作最好是在本地变基，不要对远程仓库变基（强制 push 有覆盖别人代码的风险~）

## 截取几个 commit 进行合并变基

![](https://raw.githubusercontent.com/easterfan/picgo/master/blingbling/2020/20200414220751.png)

## 修改远程仓库 commit 信息
![](https://raw.githubusercontent.com/easterfan/picgo/master/blingbling/2020/20200414220929.png)

## 一个注意事项
避免使用 `git push -f`,可以在 push 之前，先  fetch，再  rebase  

```bash
git fetch origin master
git rebase origin/master
git push
```


# 参考
- https://segmentfault.com/q/1010000000430041
