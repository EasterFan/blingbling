# 用好 IDEA

## 常用配置
### 主题配置
http://color-themes.com/ 或者 **material theme ui** 插件(方便！)

### 设置背景
打开命令控制台后，set background

### 自动编译
在IDEA中进行手动打开自动编译设置，不需要每次写完代码后又要进行手动编译。
界面设置：File-->Settings-->Build,Execution,Deployment-->Compiler， 勾选 Compiler中`Build project automatically`


### idea 设置代理
> 否则 android sdk 无法下载

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200708114849.png)

### 设置 code-style
添加 google-code-style, [在这里下载 https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml](https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml)  

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/20200317144632.png)

### 设置显示文件tabs左显示
界面设置File-->Settings-->Editor--> general--> Editor Tabs,在 Placement 设置Left以及Tab limit为20即可。


### 项目文件编码

在文件中输入文字时会自动的转换为Unicode编码，然后在IDEA中开发文件时会自动转为文字显示，这样可以防止文件乱码。
界面设置File-->Settings-->Editor-->File Encodeings，勾选✔File Encodeings中的Transparent native-to ascii conversation

### Live Template


### keymap 设置

## 常用快捷键
### ide basic config
⌘ + Shift + F12：切换最大化编辑器
⌘ + 1：隐藏显示工程面板
⌘ + 5：隐藏显示Debug面板
⌘ + ,：打开IDEA系统设置
⌘ + ;：打开项目结构对话框
⌘ + Shift + A：查找动作（可设置相关选项）
Ctrl+**`**: 切换主题、切换演出模式、切换免打扰模式


### Navigation
Ctrl + E – recent files, search is possible.  
Ctrl + Shift + E – recent edited files, search is possible.  
Alt + 1 – open/close projects window.  
Ctrl + Shift + F12 – hide/show all windows.  
Ctrl + H – type hierarchy.  
Ctrl + Alt + H – method hierarchy.  
Ctrl + F12 – show class structure with methods.  
Alt + 7 – open/close structure window.  
Alt + F12 – shows terminal (cmd)
Alt + Home – jump to Navigation Bar (it should be enabled from View -> Navigation Bar).   From Navigation Bar you can use keyboard arrows to navigate through packages.  
Ctrl + Alt + S – opens settings.  
Click on a module + F4 – opens module settings.  
Ctrl + **`** – shows a quick menu to customize the layout.  

### Search
Ctrl + N – search and open types, search by camel case letters is possible, wildcards supported, :40 leads to line 40.  
Ctrl + Shift + N – search and open files, search for a folder is possible with a slash (/) in front, wildcards supported, :40 leads to line 40.  
Ctrl + Shift + Alt + N – search for symbol, filter by namespace is possible with dot.  
Shift, Shift – search everywhere, TAB changes the resulting cluster, left arrow key gives history, right arrow key moves forward, by default recent files are shown.  
Ctrl + Shift + A – looks up an action.  

### Code browsing【done】
option + F7 – find usages.  
command + B – go to declaration.  
command + Alt + B – go to implementation.  

### Edit
Shift + Ctrl + L – auto format code.  
Ctrl + W – select word, then next, then line, then method, then class, then whole file.  
Shift + Alt + Up/Down – move selected code or line on which cursor is up and down.  
Ctrl + Y – delete line.   This is really confusing for many users.   Many applications, such as Microsoft products, office applications, etc.  , use Ctrl + Y to redo actions, here it deletes line, and when you then do Ctrl + Z – undo you get your self into a real movie.  
Ctrl + D – duplicate line.  
Ctrl + C – copy.  
Ctrl + V – paste.  
Ctrl + Z – undo.  
Ctrl + Shift + Z – redo.  
Shift + F6 – rename class, method, field, variable, etc.  
Ctrl + Shift + Alt + T – show complete re-factoring menu.  
Alt + Insert – automatically generate getters, setters, toString, etc.  
Alt + Enter – shows available actions that can be performed on given piece of code.  
Alt + Enter -> Inject language or reference -> show nice editor for JSON for e.  g.  
Ctrl + P – get parameter info for a given method.  
Ctrl + Shift + Space – smart completion, it can be invoked second time over the first completion.  
Shift + Ctrl + Enter – complete current statement, insert semicolon.  
Ctrl + Alt + V – extract variable from piece of code cursor is placed in.  
Ctrl + Alt + T – opens predefined templates.  


### Debbuging
Ctrl + Shift + F8 – show all breakpoint, same is done with right click on breakpoint.  
F10 – select a configuration to run.  
Shift + F10 – run currently selected configuration.  
F9 – select a configuration to debug.  
Shift + F9 – debug selected configuration.  
Ctrl + F2 – stop running application.  
F7 – step into a method in case of debugging.  
F8 – step over the method in case of debugging.  
F9 – resume program in case of debugging.  
Ctrl + F9 – build code.  
Alt + F8 – show evaluate window during debugging.    

## 常用插件
 - SequenceDiagram - 根据代码调用链路生成时序图，堪称神器
 - Alibaba Java Coding Guidelines -  Alibaba开发规约，扫描潜在的代码隐患
 - Material Theme UI - 主题包  
 - lombok - 代码简化
 - GenerateSerialVersionUID

## 参考
- [javaZone比较推荐 - https://automationrhapsody.  com/intellij-idea-keyboard-combinations/](https://automationrhapsody.  com/intellij-idea-keyboard-combinations/)
