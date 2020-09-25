
<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [集合和数组的区别、集合的使用场景](#集合和数组的区别集合的使用场景)
- [集合体系的共性方法](#集合体系的共性方法)
  - [1. 父接口中的增删改](#1-父接口中的增删改)
  - [2. 迭代器取出对象  -- 查](#2-迭代器取出对象-----查)
  - [3. 三大集合间的区别](#3-三大集合间的区别)
- [集合工具类 Collections](#集合工具类-collections)
  - [1. 对 List 集合排序](#1-对-list-集合排序)
  - [2. List 集合二分查找 -- binarySearch](#2-list-集合二分查找----binarysearch)
  - [3. 替换反转](#3-替换反转)
  - [4. 集合同步](#4-集合同步)
- [集合工具类 - Arrays](#集合工具类---arrays)
  - [1. equals 和 deepEquals](#1-equals-和-deepequals)
  - [2. toString 数组转字符串](#2-tostring-数组转字符串)
  - [3. asList 数组转 List集合](#3-aslist-数组转-list集合)
  - [4. 集合转数组](#4-集合转数组)
- [集合与泛型 - 为什么在集合中使用泛型？](#集合与泛型---为什么在集合中使用泛型)
  - [泛型类介绍](#泛型类介绍)
  - [泛型方法的写法和使用场景](#泛型方法的写法和使用场景)
    - [1. 泛型方法使用场景](#1-泛型方法使用场景)
    - [2. 泛型写法](#2-泛型写法)
    - [3. 静态方法的泛型](#3-静态方法的泛型)
  - [泛型接口](#泛型接口)
  - [泛型高级应用 -- 泛型限定](#泛型高级应用----泛型限定)
    - [1. 泛型限定 -- 通配符](#1-泛型限定----通配符)
    - [2. 泛型限定 -- 上限](#2-泛型限定----上限)
    - [3. 泛型限定 -- 下限](#3-泛型限定----下限)
<!-- TOC END -->


# 集合和数组的区别、集合的使用场景
> 数据多了用对象存, 对象多了用数组和集合存

面向对象语言对事物的体现都是以对象的形式,所以为了方便对多个对象的操作,就对对象进行存储,集合就是存储对象最常用的一种方式。
1. 数组和集合的区别?
  - 两者都可以存储对象, 数组长度固定，集合长度可变  
  - 数组中可以存储基本数据类型,集合只能存储对象(jdk1.5以后, 基本数据类型有自动拆箱装箱动作,所以集合中存储的基本数据类型,都被自动转成了对象)
  - 集合可以存储不同类型的对象, 数组只能存储同一种数据类型


2. 集合的使用场景  
```bash
无法预测存储数据的数量
同时存储具有一对一关系的数据(键值对)
需要进行数据的增删改查
数据重复问题
```

3. 集合的体系
> 为什么会出现这么多容器?因为每一个容器对数据的存储方式不同, 这个存储方式 -- 数据结构

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/collection_structure.png)

list: 序列 Queue: 队列 set: 集  
list和Queue存放有序可重复的值，元素存取是有序的  
set存放无序不可重复的值，元素存取是无序的  
map存放不可重复的键值对 。  

# 集合体系的共性方法
> Collection 父接口中的增删查改方法

## 1. 父接口中的增删改
| 增  | 删           | 查     | 改                                         | 判断              |
| --- | ------------ | ------ | ------------------------------------------ | ----------------- |
| add | remove clear | 迭代器 | retainAll-->保留交集  removeAll-->删除交集 | contains  isEmpty |

## 2. 迭代器取出对象  -- 查
> 娃娃机中的夹子就是一个迭代器, 对集合的遍历有两种: 迭代器 || 增强型for循环

因为 list , set , map 底层对数据的存储方式不同, 无法在外部定义一个通用的方法来取出三个容器中的对象,  

所以就把取出方法定义在三个集合的内部, 这样, 这个定义在集合内部的取出函数就可以直接访问集合内部存储的所有对象.  

于是,这个取出函数就被定义成了内部类  

每一个容器的数据结构不同, 所以取出的动作细节也不一样, 但是都有共性内容: 判断和取出 -- 所以可以将共性抽取成一个Iterator接口(统一的规则),  

然后通过一个对外提供的方法`iterator()`让调用者获取集合的取出对象.  

```java
// 迭代器遍历
        Iterator it = list.iterator();
        while(it.hasNext()){
            System.out.println("iterator遍历结果:"+it.next());
        }

// 迭代器在局部变量中, 这种写法, 使迭代器用完后就释放, 内存友好        
        for(Iterator iterator=list.iterator();iterator.hasNext();){
            System.out.println(iterator.next());
        }

// 增强型 for 循环遍历集合
        for(String i : list){
           System.out.println(i);
        }
```
[Collection接口共性方法](https://github.com/EasterFan/JavaExercise/blob/master/ListProj/src/list/CollectionCommonFunction.java)

**增强型for 循环和 迭代器的区别:**  
两者都可以遍历集合, 但增强型for循环更有局限性:  
增强型for循环只能查找集合, 不能进行增删操作;  
Iterator 可以进行查,删操作;  
ListIterator 可以进行增删查改操作.

**传统for循环和高级for循环的区别:**  
高级for循环具有局限性 -- 必须要有被遍历的对象,即不能这样写(`for( : )`)  
遍历集合时,建议使用传统for, 因为传统for可以操作角标,

**高级for循环遍历 Map**  
```java
 HashMap<Integer,String> map = new HashMap<>();

        map.put(1,"aa");
        map.put(2,"bb");

        Set<Integer> keySet = map.keySet();
        for(Integer i : keySet){
            System.out.println(i);
        }

        Set<Map.Entry<Integer,String>> entrySet = map.entrySet();
        for(Map.Entry<Integer,String> entry : entrySet){
            System.out.println("key : " + entry.getKey() + ",value :"+ entry.getValue());
        }
```

## 3. 三大集合间的区别
1. List 元素是有序的, 元素可以重复, 因为该集合体系有索引
2. Set 元素是无序的, 元素不可以重复



# 集合工具类 Collections
> 两个集合工具类: Collections 和 Arrays, 其中都是静态方法

工具类的特点:  
没有对外提供构造方法, 不需要创建对象, 因为它的对象中没有封装特有数据,都是共享型情况下,定义成静态最方便

## 1. 对 List 集合排序
List集合本身不具备比较性, 想对List集合进行排序 -- Collections 的sort方法  

`public static <T extends Comparable<? super T>> void sort(List<T> list)`  
- T extends Comparable:  
该泛型限定对象必须实现`Comparable`接口 - 即该对象是 `Comparable`的子类, 使对象具备比较性.  

- Comparable<? super T> :  
Comparable 本身就有一个泛型限定, 限定接收该对象和该对象的父类(比较的时候有很多子类进行比较)  

[Collections 工具类--sort两种用法](https://github.com/EasterFan/JavaExercise/blob/master/MapProj/src/utilCollections/SortCollection.java)

## 2. List 集合二分查找 -- binarySearch
> 只有 list 集合才可以用二分查找 -- 二分查找必须要有角标

- 使用二分查找前**必须**对list集合进行 sort 排序,
- 如果二分查找需要传入比较器, 那么 sort 时也需要传入相同的比较器

[Colections工具类 -- 二分查找传入比较器](https://github.com/EasterFan/JavaExercise/blob/master/MapProj/src/utilCollections/BinarySearchCollection.java)  

## 3. 替换反转
> replace , reverse

1. reverseOrder -- 强行逆转比较器  
reverserOrder返回一个比较器, 该比较器可以把原比较器反转(自然排序 --> 倒序  从短到长 --> 从长到短)  

[Colections工具类 -- ReverseOrder 比较器反转](https://github.com/EasterFan/JavaExercise/blob/master/MapProj/src/utilCollections/ReverseOrder.java)

## 4. 集合同步
> 集合中所有对象都有一个共同的特点 -- 线程不安全(因为高效), 如果集合对象被多线程操作时,怎样安全使用(自己加锁很麻烦)? --- synchronizedList/Map/Set

[Colections工具类 -- Sync同步集合](https://github.com/EasterFan/JavaExercise/blob/master/MapProj/src/utilCollections/SyncCollections.java)

# 集合工具类 - Arrays

## 1. equals 和 deepEquals
equals 比较两个数组类型是否相等(数组元素是否为同一数据类型--int,boolean),  
deepEquals 比较两个数组类型是否相等 && 数组元素是否相同  

## 2. toString 数组转字符串
> 以前用 StringBuffer 做的, 现在可以直接用 Arrays.toString方法

[Arrays工具类 -- toString数组 --> 字符串](https://github.com/EasterFan/JavaExercise/blob/master/MapProj/src/utilArrays/ArrayToString.java)  

## 3. asList 数组转 List集合
为什么要把数组转为list集合?    
好处: 可以用集合的思想和方法来操作数组, 否则要自己写各种方法  
数组的方法较少,集合的方法很多.  

**注意:**  
1. 数组转为集合后, 不能用集合的**增删方法**,  
因为数组长度是固定的, 集合长度是可变的  
2. 数组转集合的两种情况  
如果数组中的元素都是对象, 那么变成集合时,数组中的元素直接转为集合中的元素,  
如果数组中的元素都是基本数据类型, 那么变成集合时,该数组转为集合中的一个元素,   
因为集合中只能存放对象, 数组中既可以存放对象,又可以存放基本数据类型

[Arrays工具类 -- 数组 --> 集合](https://github.com/EasterFan/JavaExercise/blob/master/MapProj/src/utilArrays/ArrayToList.java)  

## 4. 集合转数组
为什么要将集合变数组?  
为了限定对集合的操作,自己对集合操作完成后, 不希望别人对该集合进行增删操作(只允许查询), 故将该集合转为数组返回  

[Arrays工具类 -- 数组 <-- 集合](https://github.com/EasterFan/JavaExercise/blob/master/MapProj/src/utilArrays/CollectionToArray.java)


# 集合与泛型 - 为什么在集合中使用泛型？

> 泛型: jdk 1.5 的新特性, 用于解决安全问题, 是一个安全机制

集合中可以存储不同类型的对象, 但是我们在遍历的时候,并不知道我们遍历了不同的对象, 从而造成了类型转换异常(Class Cast Exception),  

这个异常是运行时异常, 只有在运行时才产生(根据输入具有随机性,有可能测试时通过,客户运行时出错),  

泛型的功能是, 把这个运行时异常转换为编译时异常, 如果存在类型转换的安全隐患, 程序在编译时就会报错, 防范于未然

泛型的实现是借鉴了数组的特性, 数组在初始化时就定义了数组类型(int 类型或 String类型),如果存入错误的类型,编译都不能通过.  

泛型也是借鉴了这一点, 在集合初始化时,就定义了集合的存储类型,这时,集合就只能存储一种数据类型了`ArrayList<String>`

**在集合中使用泛型有什么好处？？**  

1. 将运行时期出现的问题`ClassCastException`转移到编译时期,方便程序员解决问题,让运行时期问题减少, 安全.  
2. 避免迭代遍历时,强制类型转换的麻烦  
需要将迭代器也设置成泛型, [TreeSet - 让集合具备比较性 - 泛型写法](https://github.com/EasterFan/JavaExercise/blob/master/SetProj/src/generic/StringTreeSetWithoutClassCast.java)

## 泛型类介绍
迭代器选择器通过实现接口,来实现泛型, 自定义的类如何具有泛型属性呢? -- 继承泛型类  

为什么要让自定义的类定义泛型?  
对于工具类, 要接收多个不同类型的对象, 没有泛型机制时, 通过使用 Object 对象向上转型来接收所有对象, 但这样有一个问题: 在读取 Object 时, 可能会出现类型转换异常, 泛型可以让类型转换异常在编译时暴露出来.  

什么时候定义泛型类?  
当类中要操作的对象有多个不同对象的时候(或对象类型不确定的时候),  
早期用 Object 完成扩展,  
现在用泛型完成扩展.  

```java
/**
 * 现在的泛型写法  -- 泛型类
 */
class GenericTool<Animal>{
    private Animal animal;

    public void setAnimal(Animal animal){
        this.animal = animal;
    }

    public Animal getAnimal(){
        return animal;
    }
}
```
[泛型类 -- 工具类拓展](https://github.com/EasterFan/JavaExercise/blob/master/SetProj/src/generic/GenericClass.java)

## 泛型方法的写法和使用场景
> 泛型不仅可以定义在类上, 还可以定义在方法上,泛型方法比泛型类更灵活

### 1. 泛型方法使用场景
什么时候使用泛型类, 什么时候使用泛型方法?  

若一个类**接收的对象类型不确定**时, 使用泛型类,  
若一个方法**接收的对象类型不确定**时, 使用泛型方法

### 2. 泛型写法
泛型方法的格式: 写在修饰符之后, 方法返回值之前  

```java
public <F> void show(F f){
        System.out.println("show:"+ f);
    }

    public <F> void print(F f){
        System.out.println("print: " + f);
    }
```
[泛型 -- 泛型方法](https://github.com/EasterFan/JavaExercise/blob/master/SetProj/src/generic/GenericFunc.java)

### 3. 静态方法的泛型
静态方法不能使用定义在类上的泛型 -- (静态方法优先于类加载进内存, 静态方法执行时, 泛型类还没有加载进内存, 故无法使用)  

若静态方法接收的对象数据类型不确定, 只能在静态方法上加泛型
```java
  // 静态方法泛型
    public static <P> void method(P p){
        System.out.println(p);
    }
```

##  泛型接口
> 不多见, 有两种实现方式

```java
interface  inter<T>{
    public void show(T t);
}

/**
 * 实现一: 在实现接口时,就指定泛型类型
 */
class Interimpl implements inter<String>{

    @Override
    public void show(String string) {
        System.out.println("实现一: 在实现接口时,就指定泛型类型" + string);
    }
}

/**
 * 实现二: 在实现接口时, 仍然不指定泛型类型
 * @param <T>
 */
class InteImplment<T> implements inter<T>{

    @Override
    public void show(T t) {
        System.out.println("实现二: 在实现接口时, 仍然不指定泛型类型" + t);
    }
}
```
[泛型 -- 泛型接口](https://github.com/EasterFan/JavaExercise/blob/master/SetProj/src/generic/GenericImpl.java)

## 泛型高级应用 -- 泛型限定
> 泛型限定的范围:  
1. 通配符: ?
2. 上限: ? extends Person
3. 下限: ? super Person

### 1. 泛型限定 -- 通配符
使用泛型通配符后, 就不能调用具体的属性,因为传入的对象类型未知,无法确定调用的是哪个对象的哪个属性
```java
public static void printColl(ArrayList<?> arr){
        for(Iterator<?> it = arr.iterator();it.hasNext();){
            System.out.println(it.next());
            // 不可调用原来的属性
            System.out.println(it.next().length);
        }
    }
```
就和多态一样, 优点是提高了扩展性, 缺点是不能再调用原来的方法了
[泛型限定 -- 通配符](https://github.com/EasterFan/JavaExercise/blob/master/SetProj/src/generic/GenericFanwei.java)

### 2. 泛型限定 -- 上限
> 上限: ? extends Person ==> 接收 Person 类型和 Person 的子类型

```java
// 上限, 接收 Person22 和 Person22 的所有zi类 -- 可调用特有属性
public static void printColl(ArrayList< ? extends Person11> per){
        for(Iterator<? extends Person11> it = per.iterator();it.hasNext();){
            System.out.println(it.next().getName());
        }
    }
```
TreeSet 的构造器就用到了上限限定
[泛型限定 -- 上限](https://github.com/EasterFan/JavaExercise/blob/master/SetProj/src/generic/GenericUpper.java)

### 3. 泛型限定 -- 下限
> 下限: ? super Person ==> 接收 Person 类型和 Person 的父类型

```java
 // 下限, 接收 Student22 和 Student22 的所有父类 -- 不可调用特有属性
    public static void printSuper(TreeSet<? super Student22> tree){
        for(Iterator<? super Student22> it = tree.iterator();it.hasNext();){
            System.out.println(it.next().toString());
        }
    }
```
[泛型限定 -- 下限](https://github.com/EasterFan/JavaExercise/blob/master/SetProj/src/generic/GenericLower.java)
