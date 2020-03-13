> 快速过一遍 java 基本语法
关键词： `JDK`，`JVM`，`变量和常量`，`关键字`，`标识符`，`数据结构`，`运算符`，

<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [Java 介绍](#java-介绍)
  - [JAVA 程序是怎样执行的？](#java-程序是怎样执行的)
  - [JDK、JRE、JVM 之间的关系？](#jdkjrejvm-之间的关系)
  - [java 适用的场景？](#java-适用的场景)
  - [Java 的组成成分](#java-的组成成分)
- [变量和常量 - java 语言的最小组成单位](#变量和常量---java-语言的最小组成单位)
  - [1.标识符](#1标识符)
  - [2.关键字](#2关键字)
  - [3.变量的分类和存储](#3变量的分类和存储)
  - [4.常量的分类和存储](#4常量的分类和存储)
  - [5.注释](#5注释)
- [java的六大数据类型](#java的六大数据类型)
  - [数据类型的存储大小](#数据类型的存储大小)
  - [数值型 -- 整数](#数值型----整数)
  - [数值型 -- 浮点](#数值型----浮点)
  - [字符型](#字符型)
  - [基本数据类型的转换](#基本数据类型的转换)
- [运算符](#运算符)
  - [一. 算术运算符](#一-算术运算符)
  - [二. 赋值运算符](#二-赋值运算符)
  - [三. 关系运算符](#三-关系运算符)
  - [四. 逻辑运算符](#四-逻辑运算符)
  - [五. 条件运算符](#五-条件运算符)
  - [六. 位运算符](#六-位运算符)
<!-- TOC END -->

# Java 介绍
>  程序的执行过程，JDK，JRE，JVM，Java 的组成和作用

## JAVA 程序是怎样执行的？

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180103190340172.png)

java 编译器将 .java文件编译成 .class 字节码文件, JVM 将字节码解释执行 ,转换成具体平台上的机器指令, 实现一次编译,到处运行.  

## JDK、JRE、JVM 之间的关系？
#### 1. JDK(java开发工具包)

JDK中有两大组件:  
- javac 编译器 -- .java 转为 .class
- java  解释器 -- 运行 .class 文件

#### 2. JRE(java 运行环境)  

- 包括 JVM , java 核心类库和支持文件.  
- 如果要运行编译后的 java 文件,需要安装 jre；如果要开发 java 程序,需要安装jdk     
- jdk 中附带有 jre

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-2018010319172472.png)

## java 适用的场景？

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180103191902553.png)  

## Java 的组成成分
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/contain.png)

# 变量和常量 - java 语言的最小组成单位

## 1.标识符

> java 严格区分大小写

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180104121304561.png)

- 包名:多单词组成时所有字母都小写。  
xxxyyyzzz  
- 类名接口名:多单词组成时,所有单词的首字母大写。  
XxxYyyZzz  
- 变量名和函数名:多单词组成时,第一个单词首字母小写,第二
个单词开始每个单词首字母大写。  
xxxYyyZzz  
- 常量名:所有字母都大写。多单词时每个单词用下划线连接。   
XXX_YYY_ZZZ

## 2.关键字

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180103210323746.png)

## 3.变量的分类和存储
- 变量的组成  
`int a = 1;`  
变量由变量类型,变量名,变量值三个部分组成.

- 变量的分类  
按照变量的作用范围,变量可以分为:  
类级,对象实例级,方法级(局部变量),块级  

| 分类         | 成员变量                                                 | 局部变量                                                     | 类变量                                                           |     |     |     |
| ------------ | -------------------------------------------------------- | ------------------------------------------------------------ | ---------------------------------------------------------------- | --- | --- | --- |
| 作用范围     | 定义在类中,在整个类中都可以被访问                        | 只定义在局部范围内. 如:函数内/语句内等。                     | 类变量是加了static 的成员变量;定义在类中; 在整个类中都可以被访问 |     |     |     |
| 存储位置     | 成员变量随着对象的建立而建立；存在于对象所在的堆内存中。 | 局部变量存在于栈内存中。作用的范围结束；变量空间会自动释放。 | 随类的加载而建立;存在与方法区中;随类的回收而消失,生命周期最长    |     |     |     |
| 默认初始化值 | 有                                                       | 无                                                           | 不确定                                                           |     |     |     |



- 变量的存储  
java 将内存分为三个部分:**堆,栈,常量池,方法区,本地方法区,寄存器**  

![](../assets/markdown-img-paste-20180104094443744.png)  

java中变量存在**栈**里,常量存在**常量池**里,new出来的存在**堆**里.  

**局部变量**:  
局部变量存储在栈中,比如`int a = 100`,计算机执行这条语句时,就会在内存的栈中开辟一个 4 字节的大小,存放 100 这个int整型.

> 变量如果没有被初始化,就不能被使用

```java
int x;
System.out.print(x);   // 报错; x没有被初始化赋值,不能被使用
```

## 4.常量的分类和存储
> 常量表示不能改变的数值

常量的分类:  
1. 整数常量。所有整数
2. 小数常量。所有小数
3. 布尔型常量。较为特有,只有两个数值。true false。
4. 字符常量。将一个数字字母或者符号用单引号( ' ' )标识。
5. 字符串常量。将一个或者多个字符用双引号标识。
6. null常量。只有一个数值就是:null.
7. 被final修饰的变量

常量和变量都有数据类型,一般常量名用大写字母表示;
```java
final double PI = 3.14;
final MIN_VALUE = 0;

```
常量存储在内存的**常量池里**  

## 5.注释
> 单行注释和多行注释被忽略, 文档注释解析成 javadoc

```java
// 单行注释


/*多行注释*/


/**

文档注释 - 可被解析成 javadoc
*/

```

# java的六大数据类型
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180103212412737.png)  
(整数默认:int  小数默认: double)  

## 数据类型的存储大小
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180103212802654.png)

## 数值型 -- 整数
> 十进制,八进制,十六进制表示整型

- 八进制  
以 0 开头,包括 0-7 的数字.  
`037, 056`  

- 十六进制  
以0x开头,包括 0-9 和字母 a-f  
`0x12, 0xabcf, 0xabcff, 0xabcfL`  
十六进制后的L表示这是一个**长整型**  
`long a = 0xabcfL`

## 数值型 -- 浮点
> 默认一个浮点型数据是double类型

`float a = 1.234`报错  
`float a = 1.234f`正确  

科学计数法表示浮点型数据,如1.23*10^5  

```java
double d = 1.23E5;
float f = 1.23E5f;
```

## 字符型
> 整型和字符类型可以相互转换 --- ASCII码

ASCII码的作用,是为了将计算机传输的二进制整数000111转换成字母.  

但是这个整数范围为:[0-65535],如果在此范围之外,需进行强制类型转换 -- 不建议这样,会造成数据丢失

```java
char c = 'c';
char a = 65;
System.out.print(a);   // 输出 A
```

ASCII码只能将二进制转换成字母,后来出现Unicode编码,Unicode的目标是能够将二进制整数转换成世界上所有的字符.  

Unicode的表示法,是在值前加前缀**\u**+**4位十六进制**  
```java
char c = '\u005d';
System.out.print(c);   // 输出 [
```

转义字符:  

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180104105213630.png)
在使用转义字符时,一定要有一个双引号,进行字符串拼接,如果全是转义字符,计算机会把所有的转义字符自动转换成整型数字.  

```java
int x=1, y=2;
System.out.println(x + '\t' + y + '\n');
System.out.println(x + "\t" + y + '\n');
System.out.println("" + x + '\t' + y + '\n');
```

## 基本数据类型的转换

- 自动类型转换

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/autoChange.png)
实线为无数数据损失的转换,虚线为可能发生数据丢失的自动转换.

- 强制类型转换
若A类型的数据表示范围比B类型大,则将A类型的值赋给B类型,需要强制类型转换.  

```java
// 整型转字符  自动与强转
char c1 = 65;
char c2 = (char)65536;


// long 转 float 自动转损失数据
float f1  = 102984762874647657283477L;
System.out.println(f1);    // 1.029847628e20

```

# 运算符
> 运算符包括:算术,赋值,关系,逻辑,条件,位运算符


## 一. 算术运算符
自增自减运算

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180104143112665.png)

除法运算,如果两个数都是整数,最后结果就是整数；
如果两个数中有一个数是小数,最后结果保留小数.  

## 二. 赋值运算符

将右边的值赋给左边的变量.  
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180104134412377.png)

## 三. 关系运算符
> 关系运算符主要用于条件和循环语句中的判断条件


```java
        // 两个字符相比,比较的是两个字符的ASCII值
        char a = 'A';
        char b = 'B';
        System.out.println(a > b);     // false

        // 浮点数与整数相比,只要值相等,返回的就是true
        float f = 5.0f;
        long l = 5;
        System.out.println(f==l);     // true
```

## 四. 逻辑运算符

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180104172431318.png)

&& 和 || 都是短路运算符  
如果第一个表达式的值就能确定表达式的最终结果,那么右边的表达式就不被执行了.  

```java
   int n = 3;
        boolean d = (3>7) && ((n++) < 2);
        System.out.println(n);              // 3  被短路,后一个表达式没有被执行
        System.out.println(d);              // false
```

## 五. 条件运算符
> 布尔表达式 ? 表达式1 : 表达式 2


## 六. 位运算符
> 位运算是直接对二进制进行运算. 位运算是效率最高的运算

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/wei1.png)  
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/wei2.png)  

#### 1. 左移/右移
> 左移数值变大,右移数值变小(右移把有效位挤没了)  

以 `3 << 2 = 12`为例:  

```bash
右移前:
[高位]  |0000-0000 0000-0000 0000-0000 0000-0011| [低位]

右移后 - 挤掉高位,低位补2个0:
[高位]  00|00-0000 0000-0000 0000-0000 0000-001100| [低位]
```

**万能公式**  
```bash
左移: m << n = m * 2^n
右移: m >> n = m / 2^n
```

**>>和 >>> 的区别**  

右移后,`>>`最高位补0补1,视情况而定.  
`>>>`全部补0  


#### 2. 与/或运算 -- & |
> 将 0 看作假, 1 看作真

```bash
# 6 & 3

  110
& 011
------
  010

# 6 | 3

  110
| 011
------
  111

```

#### 3. 异或运算 -- ^
> 同号(00/11)为假(0),异号(10/01)为真(1)

异或的一个特性: **一个数异或同一个数两次,结果还是那个数 m ^ n ^ n = m**  
此特性可用于**数据加密**,n 相当于密钥.

```bash
# 计算 7 ^ 4 ^ 4
7(111) 4(100)

 111
^100
------
 011
^100
-----
 111

```

#### 4. 反码 -- ~
> 0 变 1；1 变 0

~ 6 = -7  

```bash
6 的二进制`110`:
[高位]  |0000-0000 0000-0000 0000-0000 0000-0110| [低位]

取反码:
[高位]  |1111-1111 1111-1111 1111-1111 1111-1001| [低位]
```

## 运算符的优先级

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180104180159152.png)  
