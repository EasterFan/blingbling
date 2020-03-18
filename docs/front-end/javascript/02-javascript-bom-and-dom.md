> BOM 和 DOM 对象

<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [BOM 7 个对象](#bom-7-个对象)
  - [1. window对象](#1-window对象)
  - [2. location对象](#2-location对象)
  - [3. history 对象](#3-history-对象)
  - [4. screen 对象](#4-screen-对象)
  - [5. naigator对象](#5-naigator对象)
- [DOM 元素](#dom-元素)
- [DOM 事件](#dom-事件)
- [DOM 和 BOM 的联系](#dom-和-bom-的联系)
<!-- TOC END -->


# BOM 7 个对象
什么是BOM？  
BOM(browser object model)浏览器对象模型，BOM对象有7个：
**window navigator screen history location document event**  

## 1. window对象
window是浏览器的一个实例,在浏览器中,window对象有双重角色,它既是通过JavaScript访问浏览器窗口的一个接口,又是ECMAScript规
定的Global对象。window是BOM的核心对象。

```
1. window对象的全局性--声明全局变量和全局函数
window声明的变量是全局变量，window声明的方法是全局方法。ECMAScript规定了window是一个Global对象。
声明一个全局变量：window.username="fdf" ---等价于 var username="fdf"  
声明一个全局方法：window.sayName=function(){
        alert("我是"+this.username);
}                                    ----等价于 function sayName(){}
调用一个全局方法：window.sayName();

2. window对象是JS访问浏览器的接口。JS通过调用window对象提供的方法访问浏览器

- window.alert("");
功能:显示带有一段消息和一个确认按钮的警告框  

- window.confirm("");
功能:删除关闭等敏感操作，弹出二次确认窗口  
返回值:如果用户点击确定按钮,则confirm()返回true
如果用户点击取消按钮,则confirm()返回false

- window.prompt("text","defaultText");
功能：请求用户在弹出框中输入内容  
返回值:如果用户单击提示框的取消按钮,则返回null
如果用户单击确认按钮,则返回输入字段当前显示的文本

- window.open(pageURL,name,parameters)
功能:打开一个新的浏览器窗口或查找一个已命名的窗口

- window.close()
功能：关闭当前浏览器窗口

定时器-超时调用  
setTimeout(code,millisec)  
功能:在指定的毫秒数后调用函数或计算表达式  
说明:1. setTimeout()只执行code一次。如果要多次调用,请使用setInterval()或者让code自身再次调用setTimeout()
    2. 超时调用的函数推荐使用自定义函数或匿名函数，不要直接写在该函数中，代码执行效率低
    3. 该函数返回值是一个id，该id是该段代码执行的唯一身份标识，用clearTimeout(id)可以取消该段代码的执行。

定时器-间歇调用  
setInterval(code,millisec)  
功能：每隔指定的时间执行一次代码  
说明：1. 该函数返回值是一个id，该id是该段代码执行的唯一身份标识，用clearInterval(id)可以取消该段代码的执行。  
     2. setTimeOut反复调用自己，这种程度可以取代setInterval  
     3. setInterval + 匿名函数好用，setTimeOut + 自定义函数在取代setInterval时好用。  

window对象各种弹出框的提示信息用\n换行

```

## 2. location对象
location对象提供了与当前窗口中加载的文档有关的信息,还提供了一些导航的功能,它既是window对象的属性,也是document对象的属性。  

作用：将url拆分成独立的片段，让开发者独立地访问这些片段  

- 基础属性
**http://localhost:63342/js1/location2.html?_ijt=cbalufu13atkbgijl6rt2am8ut#top**  
```
1. location.href  
功能:返回当前加载页面的完整URL  
**http://localhost:63342/js1/location2.html?_ijt=cbalufu13atkbgijl6rt2am8ut**

2. location.hash  
功能:返回URL中的hash(#号后 跟零或多个字符),如果不包含则返回空字符串。  
**#top**  

3. location.host
功能:返回服务器名称和端口号(如果有)  
**localhost:63342**

4. location.hostname
功能:返回不带端口号的服务器名称  
**localhost**  

5. location.pathname
功能:返回URL中的目录和(或)文件名。  
**/js1/location2.html**  

6. location.port
功能:返回URL中指定的端口号,如果没有,返回空字符串。
**63342**  

7. location.protocol
功能:返回页面使用的协议。  
**http**  

8. location.search
功能:返回URL的查询字符串。这个字符串以问号开头。
**?_ijt=cbalufu13atkbgijl6rt2am8ut**

```

- 改变url三个方法  
```
1. location.href = "index1.html"  
功能：从当前页面跳转到index1.html页面  
说明：此方法会在浏览器中生成一条历史记录，即在浏览器中可后退到原来页面
    location.hash 和 location.search也可以改变url  

2. location.replace(url)
功能:重新定向URL。
说明: 使用location.replace不会在历史记录中生成新纪录，在浏览器中不可后退  

3. location.reload()
功能:刷新当前页面。
说明:
• location.reload()有可能从缓存中加载
• location.reload(true)从服务器重新加载
```

## 3. history 对象

history对象保存了用户在浏览器中访问页面的历史记录（出于安全，开发者并不能看到用户访问的页面url）  
```
1. history.back()
功能:回到历史记录的上一步
说明:相当于使用了history.go(-1)

2. location.forward()
功能:回到历史记录的下一步
说明:相当于使用了history.go(1)

3. history.go(-n)
功能:回到历史记录的前n步  

4. history.go(n)
功能:回到历史记录的后n步

```

## 4. screen 对象
```
1. screen.availWidth
功能:返回可用的屏幕宽度  

2. screen.availHeight
功能:返回可用的屏幕高度

3. window.innerHeight  
功能：返回当前窗口高度

4. window.innerWidth
功能：返回当前窗口宽度

区别：screen是屏幕去掉工具栏状态栏后的可用宽高，大小是固定的  
    innerHeight是当前窗口的大小，你拖动窗口大小后，返回的值在改变
```

## 5. naigator对象
返回用户的浏览器信息  

```
UserAgent:  
用来识别浏览器名称、版本、引擎 以及操作系统等信息的内容。  
console.log(Navigator.userAgent);
```

# DOM 元素


# DOM 事件

# DOM 和 BOM 的联系
