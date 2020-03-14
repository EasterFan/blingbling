> Java 基本语法下：
关键字： `流程控制`,`数组`，`方法`

<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [流程控制](#流程控制)
  - [选择控制](#选择控制)
  - [循环控制](#循环控制)
    - [1.while](#1while)
    - [2. do..while](#2-dowhile)
    - [3. for](#3-for)
    - [4.循环嵌套](#4循环嵌套)
    - [5.break和continue](#5break和continue)
- [数组](#数组)
  - [一. 创建数组](#一-创建数组)
  - [二. 数组在内存中的存储](#二-数组在内存中的存储)
  - [三. 数组的使用](#三-数组的使用)
    - [1.循环为数组赋值--完成初始化](#1循环为数组赋值--完成初始化)
    - [2.求数组元素最值](#2求数组元素最值)
    - [3.增强型for循环遍历数组](#3增强型for循环遍历数组)
    - [4. 排序:选择排序和冒泡排序](#4-排序选择排序和冒泡排序)
    - [5. 二分查找](#5-二分查找)
    - [6. 数组传参 -- 可变参数列表](#6-数组传参----可变参数列表)
  - [四. 二维数组](#四-二维数组)
    - [1. 创建二维数组](#1-创建二维数组)
    - [2. 二维数组在内存中的状态](#2-二维数组在内存中的状态)
    - [3. 二维数组的使用](#3-二维数组的使用)
- [方法](#方法)
  - [方法介绍](#方法介绍)
  - [方法重载](#方法重载)
  - [参数传值](#参数传值)
  - [可变参数列表](#可变参数列表)
<!-- TOC END -->


# 流程控制
## 选择控制

> 多重if / 嵌套if / switch

if 有三种结构:  
1. if(){}
2. if(){}else{}
3. if(){}else if(){}else if(){}else{}

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180104190233728.png)  

switch语句选择的类型只有四种:byte, short, int , char, String。  

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-2018010419025486.png)  

如果判断的条件不多,且符合byte, short, int , char, String类型,推荐使用 switch.  
如果判断范围,涉及布尔值,推荐使用 if  

## 循环控制

> while  do-while for循环  循环嵌套

### 1.while

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180105171640502.png)

```java
int n = 1;   // 1. 循环变量n必须先初始化
 while (n < 5){   // 3. 表达式为true时, 语句才会被执行
            System.out.println(n);   // 语句
            n++;  // 2. 循环变量n必须改变
        }
```

### 2. do..while
> 不管表达式是否符合条件,循环都会被执行一次

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180105171509335.png)


### 3. for

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180105174817330.png)

```java
// 将10以下的值打印输出
        for(int i=1;i<=10;i++){
            System.out.print(i);
        }
```

- for循环的组成
for(初始化表达式;循环条件表达式;循环后的操作表达式)
{
执行语句;
}

```java
  int x = 0;
        for(System.out.println("a");x<3; System.out.println("c") ){
            System.out.println("b");
            x++;
        }
```

- for循环的执行顺序:  

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180105175357913.png)  
- 循环变量的作用范围:  
循环变量是局部变量,局部变量只在其所在的大括号内有效.

- for循环的三个表达式都是可省略的
第一种:省略int i
将int i拿到外面,可以扩大循环变量的作用范围.  
```java
// 将10以下的值打印输出
        int i=1;

        for(;i<=10;i++){
            System.out.print(i);
        }
```

第二种:省略判断条件
将判断条件放到里面.  

```java
// 将10以下的值打印输出

        int i=1;

        for(;;i++){
            System.out.print(i);
            if (i==10)break;
        }
```

第三种:省略i的自增  
将i++ 放到里面.  
```java
// 将10以下的值打印输出

        int i=1;

        for(;;){
            System.out.print(i);
            if (i==10)break;
            i++;
        }
```

这种情况下,可以极致的转为while  
```java
// 将10以下的值打印输出

        int i=1;

       // for(;;)
        while(true){
            System.out.print(i);
            if (i==10)break;
            i++;
        }
```

- for 和 while 的无限循环  
for(;;;){}  
while(true){}  

### 4.循环嵌套
> while 套while , do while 套while , for套 for


![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180105223241460.png)

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180105223408963.png)

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180105223442673.png)


循环嵌套写阶乘时, `int sum`, 输出结果`-2664152777252537831` 发生溢出,
输出结果已经超出int范围,可以改为`long sum`或者使用java中的大数据类.

### 5.break和continue

- break语句后的代码不会被执行(有 if 逻辑也不行)
- break在多重循环中,只向外跳出一层,结束当前所有循环
- continue后的代码会被执行(有 if 逻辑即可)
- continue结束当前循环,执行下一次循环

多重循环中,通过给循环标号, 使 break/continue 跳出指定循环.  
```java
  out:for(int x=1;x<7;x++){
           in: for(int y=1;y<x;y++){
                System.out.println(y);
                if(y==4) break out;
            }
        }
```

[continue跳过当前循环]()

# 数组
## 一. 创建数组

```java
// 声明数组:
   int arr[];
// 创建数组:
   int arr[] = new int[5];
//  初始化数组:
   int arr[] = {0,1,2,3,4};
```

声明并创建一个长度为10的整型数组.
与变量不同,我们在使用变量时,要先给变量赋值,才能使用;  
而数组本质上是一个**对象**,数组创建后都有默认值,整型数组的默认值为0.

## 二. 数组在内存中的存储
变量被赋值后,会在内存中存储,同样,创建数组后,数组也会在内存中存储.  
> 与变量不同,数组会被分配连续的内存空间

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180106112241893.png)  
例如,程序执行到这行代码时,会在内存中开辟一段长度为5的**连续的**内存空间,整型数组的默认值为0;  
**数组名a是一个对象, a 指向数组中第一个元素的内存地址.**
数组的下标从0开始.

## 三. 数组的使用
> 最值, 排序(选择排序,冒泡排序), 二分查找

### 1.循环为数组赋值--完成初始化
```java
int arr[] = new int[4];
// arr[] = {1,2,3,4};

for(int i=0; i<=4; i++){
   arr[i] = i + 1;
}
```

### 2.求数组元素最值
```java
        int max = arr[0];
        for(int i=0;i<arr.length;i++){
            if(max < arr[i]){
                max = arr[i];
            }
        }
```

### 3.增强型for循环遍历数组
```java
for (int i : arr) {  
}
```

### 4. 排序:选择排序和冒泡排序
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/bubble.jpg)  
冒泡排序和选择排序的低效在于:  
每次比较后在**堆**中交换位置,比较耗费资源；如果比较后将在堆中交换位置,改为在**栈**中交换位置,效率会高很多.  

代码实现:  
```java
// 冒泡排序
        // 最后一个元素不必遍历
        for(int i=0;i<arr.length -1;i++){
            // 内层循环,相邻的两个元素比较,每次循环减去前 n 个已经确定的元素, 且最后一个元素不必遍历
            for(int j=0;j < arr.length-i-1;j++){
                if(arr[j]>arr[j+1]){
                    changeTwoArrayElement(arr,j,j+1);
                }
            }
        }

        // 选择排序
        // 最后一个数组元素不用遍历
        for(int i = 0;i<arr.length-1;i++){
            // 前面比较过的小元素不需要再比较
            for (int j = i + 1;j<arr.length;j++){
                if(arr[i] > arr[j]){
                    changeTwoArrayElement(arr,i,j);
                }
            }
        }
```
[冒泡排序](https://github.com/EasterFan/JavaExercise/blob/master/basic/src/array/Bubble.java)  

然而,真实开发中,用`Arrays.sort()`进行数组排序.  

### 5. 二分查找
> 折半查找提高效率,但要求该数组必须为有序数组.

向一个有序数组中插入一个数,使得插入后的数组仍然是一个有序数组  
- 如果该数在数组中存在,插入到已存在数的下标中;如果不存在,返回二分查找的min值,插入.
```java
public static int getIndex(int arr[],int key){
        int min = 0;
        int max = arr.length - 1;
        int mid = (max + min) / 2;

        while (arr[mid] != key){
            if(key > arr[mid])
                min = mid + 1;
            else if(key < arr[mid])
                max = mid - 1;

            // 如果数组中无此元素,返回-1
            if(min > max) return -1;
            mid = (max + min) / 2;
        }

        return mid;
    }
```
[二分查找案例](https://github.com/EasterFan/JavaExercise/blob/master/basic/src/array/HalfSearch.java)  

### 6. 数组传参 -- 可变参数列表
当一个方法,需要向这个方法传入十几个参数时,  
```java
// 一个一个传, 很麻烦
public void show(int n1, int n2 ..... 省略十几个参数){}

// 把参数先存入数组中, 将数组作为参数传递给方法 -- 还要定义数组, 较麻烦
public void show(String arr[]){}

// 可变参数列表 -- 取代数组, 不需要自己定义数组, JVM帮你在内部自动封装
public void show(String ...str){}

// 可变参数要位于所有参数最后
public void show(int a, String ...str){}  
```
**注意:**  
当可变参数和普通参数一起传值时, 可变参数一定要定义在参数的最后面.  

[数组 - 可变参数列表](https://github.com/EasterFan/JavaExercise/blob/master/basic/src/function/ArgsChange.java)
## 四. 二维数组

### 1. 创建二维数组
> 三种方法创建

```java
// 创建二维数组
	int arr[][] = new int[3][4];
        int arr[][] = new int[3][];
        int[][] arr = {{3,8,2},{2,7},{9,0,1,6}};

```
注意特殊写法情况:int[] x,y[]; x是一维数组,y是二维数组。  

### 2. 二维数组在内存中的状态
```bash
+-------------------------+
|  +----+----+----+----+  |
|  |  3 |  5 |  2 |  6 |  |
|  +-------------------+  |
|  +----+----+----+----+  |
|  |  3 |  5 |  2 |  6 |  |
|  +-------------------+  |
|  +----+----+----+----+  |
|  |  3 |  5 |  2 |  6 |  |
|  +-------------------+  |
+-------------------------+
```
### 3. 二维数组的使用
二维数组累加和:  
```java
static int getTwoArraySum(int arr[][]){
        int sum = 0;
        for(int x = 0;x<arr.length;x++){
            for(int y=0;y<arr[x].length;y++){
                sum+=arr[x][y];
            }
        }

        return sum;
    }
```

# 方法
## 方法介绍
方法结构:  
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180106154425720.png)  

## 方法重载
> 方法名相同,参数列表不同(个数不同/数据类型不同/顺序不同),和返回值类型无关

[方法重载案例]()  
方法之间互相重载,直接方法名调用;  
在主方法中调用其他普通方法,先新建对象,然后用对象调用方法.
```java
// 方法
void show(int a, char b, double c){};
// 重载
void show(int a, double c, char b){};
// 不重载 -- 此函数不可与原函数在同一个类中
int show(int a, char b, double c){};
```
## 参数传值
> 对基本数据类型: 传递的只是参数值,对主函数中的变量值无影响
> 对数组和对象: 传递的是内存地址,普通函数的操作对数组/对象有影响

主函数中调用普通函数,进行参数传递时,主函数只是将自己的**变量的值**传给了普通函数,
无论普通函数对这个值进行怎样的操作,主函数中变量mn和mn对应的值(3,4)都不会改变,因为变量mn在内存中的地址没有改变,普通函数操作的是普通函数的内存地址.

```java
public class ChangeArge {

    public void swap(int a,int b){

        System.out.println("交换前ab:" + a + " " + b);

        int temp;
        temp = a;
        a = b;
        b = temp;

        System.out.println("交换后ab:" + a + " " + b);
    }

    public static void main(String[] args) {
        int m = 3, n = 4;
        System.out.println("交换前mn:" + m + " " + n);

        ChangeArge ca = new ChangeArge();
        ca.swap(m,n);
        System.out.println("交换后mn:" + m + " " + n);
    }
}
```
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20180106193122533.png)

但是,当传递的是数组/对象时,普通函数的操作会对主函数中的数组/对象,产生影响.  

数组名arr存储的是一个地址,它指向数组内存空间第一个元素的内存地址.参数传递时,主函数传递的,是数组的内存地址,这样,普通函数和主函数,共同引用同一块内存地址,所以,普通函数的操作,会影响数组/对象的值.  


## 可变参数列表
> 可变参数列表和数组相似,可以将数组传给可变参数列表

- 可变参数列表实现累加和查找功能
- 可变参数列表的方法重载问题
**可变参数列表所在的方法是最后被访问的,优先级最低,只要有其他带参方法,程序优先调用带参方法**
