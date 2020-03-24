> 强迫症患者怎样才能下笔如有神?

# markdown 和我的写作工作流


理想中的文档管理特点：
* [X] 搜索关键字
* [X] edit in repo
* [X] 分页
* [X] 最后编辑时间
* [X] github 挂件
* [ ] 代码高亮 （支持 Prism，但是还可以高亮一下）
* [X] 主题切换

修改后的 docsify 样式
https://github.com/epochwz/docsify-plus.git

## docsify 简单配置



## docsify 与谈笑风生区 - gitalk
申请 gitalk Application，申请完成后会得到 ClientID 和 Client Secret https://github.com/settings/applications/new

![](https://raw.githubusercontent.com/easterfan/picgo/master/blingbling/2020/20200323111054.png)

处理 gitalk 由于文章 URL 过长导致的 Validation Failed（442）问题 - 将文章目录转 md5
在网上找了一下这个库：https://github.com/blueimp/JavaScript-MD5  

在 index.html 中引入 js
```bash
<script src="{{ site.baseurl }}/js/md5.min.js"></script>

var gitalk = new Gitalk({
  clientID: 'xxxxxxxxxxx',
  clientSecret: 'xxxxxxxxxxxxxxxxxxx',
  repo: 'xxxx.github.io',
  owner: 'xxxx',
  admin: ['xxxx'],
  id: md5(location.href)
})
```

## docsify 添加 BGM
网易云音乐外链获取方法：  
```bash
# 通过分享音乐获得音乐 ID， 替换后到浏览器直接下载（虽然普通音质~）
http://music.163.com/song/media/outer/url?id=5307982.mp3
```
