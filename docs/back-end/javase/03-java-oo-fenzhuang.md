> Java 特性：封装、继承、多态
关键字：`面向对象`，`封装类`,`static`


<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [面向对象和面向过程的区别？](#面向对象和面向过程的区别)
- [创建一个类](#创建一个类)
- [创建一个对象](#创建一个对象)
    - [1. 实例化对象](#1-实例化对象)
    - [2. 对象的内存结构](#2-对象的内存结构)
    - [3. 匿名对象](#3-匿名对象)
    - [4. 对象初始化过程](#4-对象初始化过程)
- [构造方法的使用](#构造方法的使用)
    - [1. 无参构造方法、有参构造方法](#1-无参构造方法有参构造方法)
    - [2. this 语句的两种用法](#2-this-语句的两种用法)
    - [3. 构造方法的特点](#3-构造方法的特点)
- [包访问权限 - public、protected、default、private](#包访问权限---publicprotecteddefaultprivate)
  - [Jar 包的创建、查看、解压缩](#jar-包的创建查看解压缩)
- [实现封装类](#实现封装类)
    - [1. 对类进行封装](#1-对类进行封装)
    - [2. 对象通过get/set方法访问类](#2-对象通过getset方法访问类)
    - [3. 有参构造方法调用set方法](#3-有参构造方法调用set方法)
  - [包进行类管理](#包进行类管理)
- [static关键字](#static关键字)
    - [1. static (类成员)的特性](#1-static-类成员的特性)
    - [2. static 的使用](#2-static-的使用)
<!-- TOC END -->

# 面向对象和面向过程的区别？
```bash
面向过程：放（大象，冰箱）
面向对象：大象（放，冰箱）
```

这里大象就是一个对象，是一个实例。  
面向对象中，类是对象的抽象集合，包是类的管理器，是类的集合。

开发的过程:  
其实就是不断的创建对象,使用对象,指挥对象做事情。  

设计的过程:  
其实就是在管理和维护对象之间的关系  


> 定义类其实在定义类中的成员(成员变量和成员函数)

# 创建一个类
```java
package com.easter.zoo;

/**
 * 定义一个类：属性+方法
 */

public class Cat {
    // 成员属性
    String name;
    int age;
    double weight;
    String specie;

    // 成员方法
    public void eat(){
        System.out.print("猫吃鱼");
    }

    public void run(){
        System.out.print("猫跑步");
    }

}

```

# 创建一个对象
> 创建对象, 对象的内存结构,匿名对象

### 1. 实例化对象
实例化对象要在**main方法**中操作
对象可以调用类的方法，给类的属性赋值

```java
package com.easter.zoo;

public class CatInit {
    public static void main(String args[]){
        //实例化对象
        Cat katty = new Cat();

        // 对象调用类中的方法，并给变量赋值
        katty.eat();
        katty.run();
        katty.age = 18;
    }
}

```

创建类和实例化类写在两个java文件中，遵循设计模式的`单一职能原则`。  

单一原则的好处: 提高代码复用性，方便重构。

### 2. 对象的内存结构
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/ObjectInMemory.png)  

对象的本质是一个堆内存地址.  
用 = 表示将**堆**中的内存地址传递到**栈**的变量中.  
对象引用就是将堆的地址重新指给栈中变量.  

### 3. 匿名对象
> 匿名对象是对象的简化形式

匿名对象两种使用情况  
• 当对对象方法仅进行一次调用的时(方法执行完后,就被销毁)
• 匿名对象可以作为实际参数进行传递(相比有名对象,传递参数后,引用被销毁,堆内存立即释放)  

```java
// 调用方法
new Cat().eat();

// 传递参数
show(new Cat());

void show(Cat cat){
System.out.print("eat");
}
```

### 4. 对象初始化过程
> `Person jack = new Person("jack",20);`发生的顺序

```java
public class Person {
    private String name;
    private int age;
    private static String country = "china";
    private static String hair;

    static {
        System.out.println("static代码块(演示静态成员变量优先于静态代码块):"+country);
    }

    {
        System.out.println("构造方法块:(演示构造方法块优先于构造方法代码块)"+"name"+name+",age"+age+",country"+country + ",hair"+hair);
    }

    Person(String name, int age){
        this.name = name;
        this.age = age;
    }

    public void setName(String name){
        this.name = name;
    }

    public static void main(String[] args) {
        Person jack = new Person("jack",20);
        System.out.println("name"+jack.name+",age"+jack.age+",country"+jack.country);
    }

}
```

1. new用到`Person.class`,故会先找到`Person.class`文件,加载到内存中
2. 执行**静态成员变量**初始化,此时`country=china,hair=null`
3. 执行**静态代码块**,对`Person.class`类进行初始化(优先于分配内存空间 -- 静态代码块优先于对象创建)
4. 在堆内存中开辟空间,分配内存地址 -- 0x0023
5. 执行**构造代码块**,此时name,age还没有被赋值,故显示默认值:`name=null,age  =0`
6. 执行**成员变量初始化**,(将`private String name;`改为`private String name = "Tom";`)此时`name=Tom,age=0`
7. 执行**构造方法**,此时`name=jack,age=20`
8. 将内存地址 0x0023 赋给栈内存中的jack

# 构造方法的使用
> 构造方法是new关键字的好搭档，帮助配置对象初始化

### 1. 无参构造方法、有参构造方法

无参:  
```java
 public Cat(){

    }
```

有参:  

```java
public Cat(String name,int age,double weight,String specie){
        this.name = name;
        this.age = age;
        this.weight = weight;
        this.specie = specie;
    }
```
四个赋值什么作用?  
这四个赋值表示的是，将**参数值**赋给**属性值**  
右边的参数值是构造函数括号里的四个参数，左边的属性值，是Cat类中定义的四个成员变量。  

### 2. this 语句的两种用法
> 两种用法: 1. 将参数传递给成员变量  2. 构造方法间相互调用

1. 将参数传递给成员变量  
this表示当前对象，程序具有就近原则，如果不指定是当前对象的name属性，程序通过就近原则就会找到局部变量name，而不是成员变量name，可以说，我们引入this关键字，是为了解决局部变量和成员变量相同的情况，帮助程序将参数存到堆中的成员变量中。  

当前对象是谁呢？  
哪个对象调用了构造函数，这个对象就是this。  
`Cat Tom = new Cat("Tom",2,8.0,"纯正蓝猫")`，  
Tom在new时调用了上面的有参构造函数，**this**指的就是**Tom**  

2. 构造方法间相互调用
> 有时只暴露一个公共的构造方法,很多私有构造方法相互调用

不允许出现构造函数死循环  
```java
Person(){
this("Jack");
}


Person(String name){
this();
}

```

### 3. 构造方法的特点

1. 构造方法名必须与**类名**相同，且无返回值
2. 构造方法不能由对象单独调用，必须配合new关键字
3. 构造方法可以没有（系统会默认给你一个无参构造方法），可以有多个，他们之间互为重载
4. 构造方法不可以被对象调用，却可以被构造方法调用（通过 **this()** ）--即构造方法之间相互调用，这句代码必须放在第一行。  
5. 一个类中默认的无参构造函数的权限和所处的类一致, 类有 public 修饰, 构造函数也有 public 修饰.


# 包访问权限 - public、protected、default、private
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/packagepermission.png)  
public:接口访问权限    
protected:继承访问权限    
default:包访问权限--当子类在同包下，是可以访问的    

## Jar 包的创建、查看、解压缩
> jar.exe 制作 java 的压缩包,

- 创建jar包  
`jar -cvf mypack.jar [包名1] [包名2]`
- 查看jar包 -- 将jar 包显示信息重定向到其他文件中  
`jar -tvf mypack.jar [>定向文件]`
- 解压缩
`jar -xvf mypack.jar`
- 自定义jar包的清单文件
`jar –cvfm mypack.jar mf.txt [包名1] [包名2]`


> 隐藏对象的信息 ,留出访问的接口  

# 实现封装类
> 1.封装类 2.留出访问接口(get/set) 3. 调用

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/2020-03-13-fengzhuang.png)  

### 1. 对类进行封装

```java
public class Cat {
    // 成员属性
    private String name;//将name属性设为私有
    int age;
    double weight;
    String specie;

    // 无参构造方法
    public Cat(){

    }

    // 有参构造方法
    public Cat(String name,int age,double weight,String specie){
        this.name = name;
        this.age = age;
        this.weight = weight;
        this.specie = specie;
    }

    // set方法获得对象传递的方法
    public void setName(String name){
        this.name = name;

    }

    // get方法向对象返回逻辑处理后的结果
    public String getName(){

        return this.name;
    }
}
```

### 2. 对象通过get/set方法访问类

```java
public class CatInit {
    public static void main(String args[]){
        //实例化对象
        Cat katty = new Cat();

        // 把Tom这个name属性传到Cat类中
       katty.setName("Tom");

       // 从Cat类中得到返回值
       System.out.print(katty.getName());
    }
}
```

### 3. 有参构造方法调用set方法
我们封装了Cat类，在set方法中添加一段逻辑代码，检查输入的参数是否符合逻辑（如将年龄设为负数）；  

在有参构造函数中，我们应该在构造函数中调用set方法，即在`this.name=name`前调用set方法检查参数是否符合逻辑

## 包进行类管理
包对类的管理，就像文件夹对文件的管理，同一个包中不能有同名的类，同名的类可以在不同的包中。

那么，怎样跨包访问类呢？

```java
//定义包
package com.easter.zoo
//1.导入包(包名+类名)
import com.easter.zoo.animal;
//2.导入包（在new时写绝对路径）
com.easter.zoo.animal.Cat tom = new com.easter.zoo.animal.Cat();
```

# static关键字
>

```java
public class Cat {
    static String name;  // 类变量
    int age;             // 成员变量

    void eat(){
        String food = "";        // 局部变量
        System.out.println("eat" + food);
    }
}
```

### 1. static (类成员)的特性
> 利: 对对象的共享区域进行单独空间存储,节省空间,没必要每个对象都存储一遍
弊: 生命周期过长 && 访问局限性

1. 随着类的加载而加载,随着类的消失而消失,说明他的生命周期最长
2. 优先于对象存在
3. 被所有对象共享, 是所有对象的共性
4. 推荐用类名调用,因为用对象调用,该对象可能还没被创建
5. 成员方法可以直接访问静态变量, 静态方法不能直接访问成员方法(可以通过new一个对象，再通过对象去调用非静态方法和属性。)
6. 定义过多的类变量, 生命周期过长, 反而造成内存紧张
7. static 只能修饰成员变量,将成员变量转为类变量,不能修饰类和局部变量
8. 静态方法中不可以写this,super关键字

### 2. static 的使用
> 类成员, 工具类, 静态代码块,主函数

###### 1. 类成员
- 类变量的使用场景  
当对象中出现共享数据时,该数据被静态修饰;  
对象中的特有属性要定义成成员变量.  

- 类方法的使用场景  
当功能内部不需要访问非静态成员时,可以将改方法定义成静态方法.  


###### 2. 工具类
> 一个严谨的工具类: public 修饰的类 + 所有方法都为 static 静态 + 私有的构造方法 + 私有的内部调用方法  

[Array工具类](https://github.com/EasterFan/JavaExercise/blob/master/basic/src/array/ArrayTool.java)  
凡是 public 修饰的都可以被文档注释器识别(`javadoc -d . -author -version ArrayTool.java`).  

###### 3. 静态代码块
随着类的加载而执行,只执行一次,  
用于**给类进行初始化**

###### 4. 主函数
> 主函数是固定格式的(只有args可改),作为程序的入口,被 JVM 直接调用


JVM 在调用主函数时, 传入的是 new String[0];
```java
	public static void main(String[] args) {
        System.out.println(args);  // [Ljava.lang.String;@61bbe9ba
        System.out.println(args.length);  // 0
    }
```
