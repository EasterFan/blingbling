> Java 面向对象中的常用类
关键字：`内部类`，`包装类`，`object类`，`String 类`，`时间类`

<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [一. 什么是内部类？](#一-什么是内部类)
  - [内部类特点](#内部类特点)
  - [成员内部类](#成员内部类)
    - [1. 获取内部类对象实例的三种方法](#1-获取内部类对象实例的三种方法)
    - [2. 内部类 && 外部类](#2-内部类--外部类)
  - [静态内部类](#静态内部类)
    - [1. 获取内部类对象实例](#1-获取内部类对象实例)
    - [2. 内部类 && 外部类](#2-内部类--外部类-1)
  - [方法内部类](#方法内部类)
    - [1. 获取内部类对象实例](#1-获取内部类对象实例-1)
    - [2. 一些限制](#2-一些限制)
  - [匿名内部类](#匿名内部类)
- [二. 什么是包装类？](#二-什么是包装类)
  - [包装类与基本数据类型](#包装类与基本数据类型)
    - [1.对应关系](#1对应关系)
    - [2.基本数据类型  ----装箱--->  包装类](#2基本数据类型------装箱-----包装类)
    - [3.包装类  ----拆箱--->  基本数据类型](#3包装类------拆箱-----基本数据类型)
  - [包装类的作用](#包装类的作用)
    - [1.常用方法--基本数据类型（整型）转为字符串](#1常用方法--基本数据类型整型转为字符串)
    - [2.常用方法--字符串转为基本数据类型（整型）](#2常用方法--字符串转为基本数据类型整型)
  - [包装类的注意事项](#包装类的注意事项)
    - [1.包装类对象间的比较](#1包装类对象间的比较)
    - [2.基本数据类型与包装类的异同](#2基本数据类型与包装类的异同)
- [三. Object 类是所有类的父类](#三-object-类是所有类的父类)
  - [Object 类的特点](#object-类的特点)
  - [Object 类方法](#object-类方法)
- [四. String 类](#四-string-类)
  - [创建字符串String对象](#创建字符串string对象)
  - [字符串特点](#字符串特点)
  - [String 字符串常用方法](#string-字符串常用方法)
    - [1. 获取](#1-获取)
    - [2. 判断](#2-判断)
    - [3. 转换](#3-转换)
    - [4. 切割和替换](#4-切割和替换)
    - [5. 比较和除空格](#5-比较和除空格)
    - [6. 字符串练习](#6-字符串练习)
  - [String / StringBuffer / StringBuilder 三者区别](#string--stringbuffer--stringbuilder-三者区别)
    - [1. 主要区别](#1-主要区别)
    - [2. 容器的特点](#2-容器的特点)
    - [3. 常用方法](#3-常用方法)
- [五. System](#五-system)
- [六. Runtime](#六-runtime)
- [七. Date](#七-date)
- [八. Calendar](#八-calendar)
- [九. Math-Random](#九-math-random)
<!-- TOC END -->



# 一. 什么是内部类？

在Java中，可以将一个类定义在另一个类里面，或者一个方法里面，这样的类称为内部类，与之对应的，包含内部类的类称为外部类。  

当描述事物时, 事物的内部还有事物,该事物用内部类来描述 -- 内部事物在使用外部事物的内容  

##  内部类特点
> 访问方式, 所处位置

1. 访问方式
内部类可以直接访问外部类中的成员,包括私有成员。(因为内部类中有一个外部类的实例 -- 外部类名.this)  
而外部类要访问内部类中的成员必须要建立内部类的对象。  

2. 位置
**Java中的内部类主要分为四种：成员内部类，静态内部类，方法内部类，匿名内部类。**  

3. 访问顺序
内部类局部变量 -- 内部成员变量 -- 外部类  

4. 修饰符
内部类可修饰为`private`, 在外部类中实现更好的封装. -- 只有成员内部类可以加访问修饰符.  

## 成员内部类
成员内部类是最常见的内部类，又称普通内部类。  
### 1. 获取内部类对象实例的三种方法

内部类在类外使用时，无法直接实例化，需要调用外部信息才能实例化。   

```java
	// 获取内部类对象实例  方法一：new 外部类 new 内部类
        Person.Heart myheart = new Person().new Heart();
        String str = myheart.beat();
        System.out.println(str);

        // 获取内部类对象实例  方法二：外部类对象.new 内部类
        Person.Heart myheart1 = tom.new Heart();
        String str2 = myheart.beat();
        System.out.println(str2);

        // 获取内部类对象实例  方法三：外部类对象.getHeart()
        Person.Heart myheart3 = tom.getHeart();
        String str3 = myheart.beat();
        System.out.println(str3);
```
### 2. 内部类 && 外部类

1. 内部类可以直接访问外部类的成员，如果出现同名，优先访问内部类中的属性。  
2. 可以使用 **外部类.this.成员** 的方式访问外部类中同名信息
3. 外部类不能直接访问内部类信息，要通过内部类实例才能访问  
[成员内部类](https://github.com/EasterFan/JavaExercise/blob/master/innerClass/src/com/easter/member/Person.java)

## 静态内部类
### 1. 获取内部类对象实例
被static修饰的静态内部类是类共享的，故 **静态内部类对象可以不依赖于外部类对象，直接创建**  

```java
	Person.Heart myheart = new Person.Heart();
        myheart.beat();
```
### 2. 内部类 && 外部类

1. 静态内部类中只能直接访问外部类的静态方法和属性，非静态方法和属性要通过对象实例调用  
2. 外部类通过**外部类.内部类.静态成员**的方式访问内部类中的静态成员。通过**new Person().age**方法访问外部类非静态属性
3. 内部类和外部类静态属性同名时，优先访问内部类属性，也可通过 **Person.age** 方法访问外部类静态成员  
4. 当内部类中有静态成员时,该内部类必须是静态类.
5. 当外部类静态方法访问内部类时,该内部类必须是静态内部类  
[静态内部类](https://github.com/EasterFan/JavaExercise/blob/master/innerClass/src/com/easter/staticinner/Person.java)

## 方法内部类
### 1. 获取内部类对象实例
无法直接获取，通过调用该方法产生对象  
方法内部类的意义：  
一是可以隐藏，二是方法内部类对象生命周期仅在方法里有效，方法执行完毕后就会销毁。  
### 2. 一些限制

1. 方法内部类作用范围是在这个方法内
2. 方法内部类中不能定义静态成员
3. 方法内部类不能用public/private/protected修饰
4. 不推荐使用abstract类修饰方法内部类，这样就不能返回对象方法了
5. 内部类定义在类中的局部位置时,只能访问该局部被final修饰的局部变量.  
[方法内部类](https://github.com/EasterFan/JavaExercise/blob/master/innerClass/src/com/easter/function/Person.java)

## 匿名内部类
#### 意义
一是为了隐藏，二是在整个程序中只使用一次，将类的定义与构建放到一起完成，简化类的编写，内存友好。  

```java
  test2.getRead(new Person() {
            @Override
            public void read() {
                System.out.println("我是读书的小明");
            }
        });
```
#### 注意
1. 匿名内部类无法使用private/public/protected/abstract/static/修饰
2. 因为匿名内部类没有名字，故匿名内部类没有构造方法，但可以通过`构造代码块`完成成员变量的初始化操作
3. 匿名内部类中不能出现静态成员
4. 匿名内部类使用前提:  
内部类必须继承一个类,或者实现接口.(除非使用奇淫技巧)  
5. 匿名内部类就是一个**匿名子类对象**,而且这个子类有点胖
6. 匿名内部类的格式: new 父类或者接口(){定义子类的内容}
7. 匿名内部类中定义的方法最好不要超过3个 -- 简化代码

```java
// 既没有继承也没有接口,使用匿名内部类的奇淫技巧 -- Object
class InnerTest{
    public static void main(String[] args) {

        // 所有对象都是 Object 子类
        new Object(){
            void function(){
                System.out.println("function run");
            }
        }.function();
    }
}

```
[匿名内部类 -- 继承](https://github.com/EasterFan/JavaExercise/blob/master/innerClass/src/com/easter/anonymous/Person.java)  
[匿名内部类 -- 接口](https://github.com/EasterFan/JavaExercise/blob/master/innerClass/src/com/easter/anonymous/InnerClassTest.java)  



# 二. 什么是包装类？
> 包装类的最常见作用:
基本数据类型 <---> 字符串类型相互转换

Java数据类型分为基本数据类型和引用数据类型，基本数据类型是不具有面向对象特征的，基本数据类型**没有属性和方法**的调用，**不能进行对象交互**，包装类的意义在于让基本数据类型拥有属性和方法，让基本数据类型进行对象化交互。  
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180103212412737.png)  
**Java中的包装类都被final修饰，不能被继承，没有子类。**  

## 包装类与基本数据类型
包装类和基本数据类型存在对应关系。  
两者通过拆箱装箱相互转化，手动转化和自动转化。  
### 1.对应关系
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/relationship.png)  

### 2.基本数据类型  ----装箱--->  包装类

```java
	int intNum = 3;
        // 装箱：基本数据类型--->包装类
        // 1. 自动装箱
        Integer selfInBox_integer = intNum;

        // 2. 手动装箱
        Integer handInBox_integer = new Integer(intNum);
```

### 3.包装类  ----拆箱--->  基本数据类型

```java
	Integer integerNum = 4;
	// 拆箱：包装类--->基本数据类型
        // 1. 自动拆箱
        int selfOutBox_int = integerNum;

        // 2. 手动拆箱
        int handOutBox_int = integerNum.intValue();
```
int包装类Integer可以拆箱成double/float/short基本数据类型,因为这四个基本类型的包装类都继承自Number父类。  

## 包装类的作用
> 基本数据类型 --- 字符串类型

### 1.常用方法--基本数据类型（整型）转为字符串

```java
// 基本数据类型转字符串---通过包装类的toString()
        Integer integer = new Integer(intNum);
        String stringFromInteger = integer.toString();
```
### 2.常用方法--字符串转为基本数据类型（整型）
两种方法：parseInt()和valueOf()  

```java
	// 字符串转基本数据类型---1.通过包装类的parseInt()
        int intFromString = Integer.parseInt(string);

        // 字符串转基本数据类型---2.通过包装类的valueOf()
        int intFromString2 = Integer.valueOf(string);

```

[包装类的拆箱装箱Demo](https://github.com/EasterFan/JavaExercise/blob/master/WrapProj/src/BasicAndClass.java)  

## 包装类的注意事项
> 包装类对象间比较   基本数据类型和包装类的异同

### 1.包装类对象间的比较
先上一段Demo

```java
public class Comparation {
    public static void main(String args[]){

        // 1. 等号两边比较的是对象---new关键字创建两个不同的内存空间，内存地址不相等
        Integer one = new Integer(100);
        Integer two = new Integer(100);
        System.out.println("one == two的结果："+(one == two)); // 1

        // 2. 等号两边比较的是int数值---由于自动装箱和拆箱
        Integer three = 100; // 自动装箱
        System.out.println("three == 100 的结果："+(three == 100)); // 2 自动拆箱

        // 3. 等号两边比较的是对象--- three和four指向对象池中同一块内存空间
        Integer four = 100;
//        Integer four = Integer.valueOf(100);
        System.out.println("three == four 的结果："+(three == four)); // 3

        // 4. 等号两边比较的是int数值---由于自动装箱和拆箱
        Integer five = 200;
        System.out.println("five == 200 的结果："+(five == 200)); // 4

        // 5. 等号两边比较的是对象--- 超出对象池范围，new新的对象
        Integer six = 200;
        System.out.println("six == five 的结果："+(five == six)); // 5

 	// 6. 等号两边比较的是对象--- double和float没有对象常量池的概念
        Double seven = 100.0;
	Double eight = 100.0;
//        Double seven = Double.valueOf(100);
        System.out.println("seven == eight 的结果："+(seven == eight)); // 6
    }
}

```
[包装类对象间的比较](https://github.com/EasterFan/JavaExercise/blob/master/WrapProj/src/ObjectPool_Wrap.java)

另外，double和float没有对象常量池的概念。String有对象常量池。number类型的包装类范围为【-128 ～ 127】。
[详见博文](http://easterpark.me/2017/11/11/Java-Object-Pool.html)
### 2.基本数据类型与包装类的异同

- 在 Java 中,一切皆对象,但八大基本类型却不是对象。  

- 存储方式及位置的不同,基本类型是直接存储变量的值保存在栈中能高效的存取,包装类型需要通过引用指向实例,具体的实例保存在堆中。  

- 初始值的不同,包装类型的初始值为 null,基本类型的的初始值视具体的类型而定,比如 int 类型的初始值为 0,boolean 类型为 false。  


# 三. Object 类是所有类的父类
## Object 类的特点
1. 继承中所有类都直接/间接继承 Object 类,  
2. 所有子类默认构造方法中第一行都是`super()`,Object的构造方法中没有`super()`  

## Object 类方法
#### 1. euqals()  
1. java中认为所有对象都具有可比性,equals 比较的是复合数据类型的内存地址  
2. 对于基本数据类型,`==`比较的是值  
对于复合数据类型,`==`和`equals`比较的是堆内存地址.  
3. **String,Integer,Date在这些类当中equals被重写,有其自身的实现，而不再是比较类在堆内存中的存放地址了。**  
4. `equals(Object obj)`本身是多态的应用, obj 是父类,使用的时候要向下转型.  
[多态 -- Object向下转型](https://github.com/EasterFan/JavaExercise/blob/master/PolyProj/src/com/easter/mytest.java)  

#### 2. toString()和hashCode()  
1. java认为所有对象都可转为字符串(即哈希值)打印  
2. toString打印的是十六进制的内存地址, 父类中这样打印没有意义,很多类都重写 toString   
3. hashCode打印的是十进制的内存地址  

```java
	MyDemo d1 = new MyDemo(4);
	System.out.println(d1.toString());
        System.out.println(Integer.toHexString(d1.hashCode()));
```

#### 3. getClass()  
> 对象都是依赖于类文件产生的, 这些类文件(编译后的class文件)都有名称,构造函数,一般方法,所以用 **Class 类** 来描述这些class文件.  

1. getClass方法用于获得该类编译后的 class 文件.  
2. 通过编译后的class文件得到对象中的变量,方法,构造函数等, 这个过程就叫做java的 **反编译**  
3. 通过 getClass 拿到 **.java文件** 编译后的 **.class文件** 后,可以做什么,参见 API 中的Class类  


# 四. String 类
## 创建字符串String对象
三种方法：  

```java
String s1 = "hello";
String s2 = new String();   // 创建一个空字符串对象
String s3 = new String("hello");
```
s1 和 s3 的区别:  
s1 在内存中有一个对象("hello"),  
s3 在内存中有两个对象(new + "hello")

## 字符串特点
- 字符串是一个特殊的对象
- 字符串一旦被初始化,就不可以被改变

## String 字符串常用方法
![](../assets/java_string_function.png)  
字符串`==`比较的是内存地址,  
且String 类重写了`equals`,使`equals`比较的是字符串对象的值   

### 1. 获取
  - 字符串的长度
  - 根据位置获得位置上的某个字母 (char charAt(int) )
  - 根据字符获得该字符在字符串中的位置(int indexOf)

### 2. 判断
  - 字符串中是否包含某一子串  
  两种方法: **boolean contains(str)**和**indexOf**  
  indexOf(str)既可以判断是否包含,也可以返回字符串的位置
  - 字符中是否为空(isEmpty())
  - 字符串是否以指定的内容开头(boolean startsWith())
  - 字符串是否以指定的内容结尾(boolean endsWith())
  - 判断字符串内容是否相同 -- 重写了 Object 的 equals 方法, -- boolean equals(str)
  - 判断内容是否相同,并忽略大小写 -- boolean equalsIgnoreCase()

### 3. 转换
网络中传输字符串，是将字符串转为字节数组（二进制），接收后将字节数组还原成String。  
  - [字符串 <---> 字符数组](https://github.com/EasterFan/JavaExercise/blob/master/StringProj/src/StringandChars.java)
  - [字符串 <---> 字节数组](https://github.com/EasterFan/JavaExercise/blob/master/StringProj/src/StringandBytes.java)  
  - 基本数据类型 ---> 字符串`String.valueOf()`

### 4. 切割和替换
- 替换: `replace(oldString,newString)`  
可以替换单个字符, 也可以替换一个单词,replaceAll()可通过正则表达式进行替换. - 如果被替换的字符不存在, 则返回原字符串

- 切割
`split()` -- 根据字符串中符号切割字符串  
`subString(StartIndex, endIndex)`取子串,第一位为0

### 5. 比较和除空格
- 大小写转换  
toUpperCase()  
toLowerCase()

- 去除两端空格  
term() -- 只去除两端空格, 不能去除字符串中间的空格

- 对两个字符串进行自然顺序比较  
`s1.compareTo(s2)`,将两个字符串的ascall值相减, 如果结果为0, 说明两个字符串相等, 反之则不相等

### 6. 字符串练习
- [字符串反转](https://github.com/EasterFan/JavaExercise/blob/master/StringProj/src/exercise/ReverseString.java)
- [A字符串在B字符串中出现的次数](https://github.com/EasterFan/JavaExercise/blob/master/StringProj/src/exercise/CountNum.java)
- [获取两个字符串中最大相同子串](https://github.com/EasterFan/JavaExercise/blob/master/StringProj/src/exercise/GetMaxSameString.java)

## String / StringBuffer / StringBuilder 三者区别

### 1. 主要区别
String 具有不可变性，StringBuilder 和 StringBufffer 可变(可存入多种类型).

JDK1.5出现一个StringBuilder,区别是 StringBuffer 是同步的(线程安全),StringBuilder是非同步(线程不安全,但速度快)

### 2. 容器的特点
> 当数据类型有多种, 需要反复操作字符串, 且最后要转回字符串时, 容器比数组方便

- 长度可变
- 可插入多种类型
- 最后可通过 toString() 转回 String

### 3. 常用方法
StringBuffer 是一个字符串容器, 可以对字符串进行**增删改查**

- StringBuffer append(int x);
- StringBuffer delete(int start, int end );
- StringBuffer insert(int index,String str);
- StringBuffer reverse();

推荐在单线程中使用 **StringBuilder** (效率), 多线程使用 **StringBuffer** (安全)

> 介绍一些常用对象: System  Runtime  Date  Calendar  Math-Random  
主要在于培养查阅 API 文档的能力

# 五. System
> System 加载的是系统的属性, System 中的属性和方法都是静态的

JVM 启动时, 获取当前系统环境,  
Properties 是 HashTable 的子类, 故可以用 map 的方法遍历 Properties  
[其它类 - System获取当前运行环境]()  

# 六. Runtime

每个java 应用程序都有一个 Runtime 类， 使应用程序能够与其运行的环境连接（java 是跨平台的）  

- 该类没有构造方法，不能直接创建对象，因为java 程序一运行，JVM 自动就创建了对象，不需要程序员自己创建对象，只需要用 getRuntime() 获取这个对象即可

```
该类不提供构造函数 -- 该类不可new 对象，那么直接想到该类中的方法都是静态的（只能用类名调用） -- 如果该类中还有非静态方法 -- 说明该类肯定提供了方法获取本类对象，而且该方法是静态的，-- 并返回值是本类型  
这种方式实现了单例设计模式,保证了对象的唯一性
```
[其他类 - Runtime获取进程杀死进程]()
# 七. Date
> Date 类中很多方法已过时, 使用其相关类 DateFormat 的子类 SimpleDateformat

SimpleDateFormat 创建时传入了一个 pattern 模式, Partten 的作用是把自己定义的模式规则和相关数据联系起来.  

`星期E`走的是本地化 -- 跟着电脑系统决定是`星期三`还是`Wed`  
[其他类 - SimpleDateFormat 自定义时间格式]()  
# 八. Calendar
> Calendar 是一个时间对象,封装了时间元素(键值对方式),用 get()方法获取

**坑点**:  
- 国外的月份比我们少一个月
- 国外每周开始是星期天

故这样写查表法:  
```java
String month[] = {"一","二","三","四","五","六","七","八","九","十","十一","十二"};
String week[] = {"","七","一","二","三","四","五","六"};
```
[其它类 - Calendar查表法单独获得时间元素]()  
[其它类 - Calendar时间元素增量]()
# 九. Math-Random
> 生成 0 - 1 之间的随机数

有两种方法: Math.random 或 Random 类,  
后者使用更简单些,省去了自己强制转换.  

[其他类 - Random随机数]()
