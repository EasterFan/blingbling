> 快速入门

## 一. 环境搭建
```bash
# 1. 安装 vscode
brew cask install visual-studio-code
# 2. "查看"->"扩展"->搜索 "hyb1996"，安装 "Auto.js-VSCodeExt"插件
```

其他操作可查看官方文档 https://github.com/hyb1996/Auto.js-VSCode-Extension
调日志

## 一. 定位控件
### 1. 使用 text 定位 - 推荐
```js
// text
let targetButton = className("android.widget.Button").textContains("看直播").findOne();

// textContains
let targetButton = className("android.widget.Button").textContains("看直播").findOne();

// 获取满足条件的单个控件

// 获取控件列表

```

findOne 和 findOnce

### 2. 使用 depth
注意 autojs 在正常模式和稳定模式下，同一个控件的 depth 属性会变化，满足：`Depth(正常) = 2Depth(稳定)`，因为稳定模式下，控件数量较少

```js
// 根据 depth 获取控件并点击
let shareBounds = depth(11).className("android.view.View").clickable(true).indexInParent(3).findOne().bounds();
let result = press(shareBounds.centerX(), shareBounds.centerY(), 1);
```

### 3. 使用固定bounds
不推荐，使用此方法后，只能专机专用，迁移性最差，但是最简单，开发速度最快

### 4. 通过子控件定位父控件

## 二. 控件操作




## 三. 其他

### 1. 等待页面加载完全后再操作
现在用的是 sleep，waitfor 使用后会造成阻塞

### 2. 如果一个方法执行时间过久，直接 kill 掉脚本，并发送通知

### 3. exists 避免空指针
```js
if (className("android.widget.Button").textContains("福利").exists()) {
     // do sth
}

textStartsWith("抱歉，根据相关法律法规和").exists()
```


## 四. 消息推送
> server 酱 + 企业微信

查看应用ID和秘钥：https://work.weixin.qq.com/wework_admin/frame#apps/modApiApp/5629499819530779
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20210220101917.png)

查看企业id  
https://work.weixin.qq.com/wework_admin/frame#profile

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20210220102523.png)
