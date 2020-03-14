> 常用集合接口和他们的实现类
关键字：`List`,`Set`,`Map`,`Iterator`

<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [List 接口和它的实现类 ArrayList、LinkedList、Vector](#list-接口和它的实现类-arraylistlinkedlistvector)
  - [List 接口特有方法 - 增删改、ListIterator](#list-接口特有方法---增删改listiterator)
    - [1. List 接口的增删改方法](#1-list-接口的增删改方法)
    - [2. List特有方法 -- ListIterator](#2-list特有方法----listiterator)
    - [3. List 元素的比较](#3-list-元素的比较)
  - [List实现类 -- ArrayList](#list实现类----arraylist)
  - [List 实现类 -- LinkedList](#list-实现类----linkedlist)
  - [List 实现类 -- Vector](#list-实现类----vector)
- [Set 接口和他的实现类 HashSet、TreeSet](#set-接口和他的实现类-hashsettreeset)
  - [Set 的特性 - 怎样比较两个元素是否相同](#set-的特性---怎样比较两个元素是否相同)
  - [Set 的实现类 -- HashSet](#set-的实现类----hashset)
    - [1. HashSet 怎样保证元素的唯一性呢?](#1-hashset-怎样保证元素的唯一性呢)
    - [2. 在HashSet中存放自定义类](#2-在hashset中存放自定义类)
  - [Set 的实现类 -- TreeSet](#set-的实现类----treeset)
    - [1. 让对象具备比较性](#1-让对象具备比较性)
    - [2. 让集合具有比较性](#2-让集合具有比较性)
- [Map 接口和他的实现类](#map-接口和他的实现类)
  - [Map 集合的共性和特性方法](#map-集合的共性和特性方法)
    - [1. Map 共性方法](#1-map-共性方法)
    - [2. Map 特性方法](#2-map-特性方法)
  - [Map 实现类 HashTable](#map-实现类-hashtable)
  - [Map 实现类 HashMap](#map-实现类-hashmap)
  - [Map 实现类 TreeMap](#map-实现类-treemap)
  - [Map 集合的扩展](#map-集合的扩展)
<!-- TOC END -->

# List 接口和它的实现类 ArrayList、LinkedList、Vector
> List 接口有三个实现类: ArrayList  LinkedList   Vector  
涉及频繁的增删, 少量的查找 -- LinkedList  
涉及频繁的查找, --- Arraylist(一般情况下都用Arraylist)

## List 接口特有方法 - 增删改、ListIterator
> List 的特点, 就是在增删查改时传入了序号参数, 精准的进行插入,删除操作

### 1. List 接口的增删改方法

| 增                                           | 删            | 查                                          | 改                 |
| -------------------------------------------- | ------------- | ------------------------------------------- | ------------------ |
| add(index,element)  addAll(index,collection) | remove(index) | get(index)  subList(from,to) listIterator() | set(index,element) |

[List接口特有方法](https://github.com/EasterFan/JavaExercise/blob/master/ListProj/src/list/ListDemo.java)  

### 2. List特有方法 -- ListIterator
> ListIterator 是 List 接口中特有的迭代器, ListIterator 是 Iterator 的子接口

**为什么用ListIterator?**   

有一种需求, 要求用 Iterator 迭代 List 容器, 一边迭代一边操作 ArrayList 列表,  

如果用`list.add`来操作, 会抛异常, 因为 arraylist 对象和 Iterator 对象同时在操作列表中存储的对象, 这样并发访问会造成数据不一致的安全隐患,  

如果想要一边迭代一边操作, 只能用迭代器的方法, 但是Iterator迭代器方法有限(只有三个), 其子接口`ListIterator`有很多方法  

```java
  ListIterator li = list.listIterator();
        while (li.hasNext()){
            Object obj = li.next();
            if(obj.equals("Sept")){
                // 增删改查都可以
                li.remove();  // 删除当前迭代对象
            }
        }
```
[List接口特有迭代器 -- ListIterator](https://github.com/EasterFan/JavaExercise/blob/master/ListProj/src/list/ListIteratorTest.java)

### 3. List 元素的比较
List 元素判断元素是否相同, 判断的是元素的 **equals** 方法  
所以要重写 equals 方法, 使 `contains remove` 在进行比较时, 自动调用重写的 `equals`

## List实现类 -- ArrayList
> 底层使用的是数组结构 - 查询速度快, 增删慢

1. ArrayList 是一个可变长度数组, 是通过50%重新 new 数组实现的
2. 在列表尾部插入或删除非常有效，更适合查找和更新元素  
3. ArrayList底层是由数组实现的，所以在ArrayList中部插入非常耗时，他适合在尾部操作，不适合在中部操作  
4. ArrayList中的元素可以为null  

[ArrayList去重](https://github.com/EasterFan/JavaExercise/blob/master/ListProj/src/arraylist/ArrayListSingle.java)  

Arraylist 存储自定义类并比较对象是否相同时,不能简单的使用contains, 需要重写equals方法  

```java
/**
     * 比较两个对象是否相同 -- 只比较 id 和 title
     * 重写equals
     * @param obj
     * @return
     */
    @Override
    public boolean equals(Object obj) {
        if(!(obj instanceof Notice)) return false;
        Notice notice = (Notice)obj;

        return this.id == notice.id && this.title.equals(notice.title);
    }
}
```
[ArrayList中添加自定义类的Demo](https://github.com/EasterFan/JavaExercise/blob/master/ListProj/src/arraylist/NoticeTest.java)  

## List 实现类 -- LinkedList
> 底层实现的是链表结构 - 查询速度慢, 增删快

#### 1. LinkedList 的特有方法
- 删除  
  - popFirst / popLast(如果列表为空,返回null, 老版本remove直接抛异常)
- 获取
  - peekFirst / peekLast(如果列表为空,返回null, 老版本get直接抛异常)
- 添加
  - offerFirst / offerLast

[LinkedList 模拟堆栈或队列](https://github.com/EasterFan/JavaExercise/blob/master/ListProj/src/linkedlist/LinkedListTest.java)

## List 实现类 -- Vector
> 底层使用的是数组结构

Vector 是同步的（安全， 速度慢），ArrayList 是异步的, 现在 Vector 已经被ArrayList 完全替代了, 多线程中自己加锁, 也不用 Vector

Vector 是在集合框架出现之前就存在的, 比较老, 当时还没有Iterator迭代器, 所以取出 Vector 中的存储对象, 用 `Enumeration` 枚举取出,   

`Enumeration` 和 `Iterator`是一样的, 前者是 Vector 的特有取出方式(因为自集合框架后, 所有集合都统一了 Iterator 迭代取出方式).  

因为`Enumeration` 的方法名都过长, 使得它已经被`Iterator`完全取代了.  

```java
// 枚举取出
        Enumeration en = v.elements();
        while(en.hasMoreElements()){
            System.out.println(en.nextElement());
        }
```

[Vector 枚举取出对象元素](https://github.com/EasterFan/JavaExercise/blob/master/ListProj/src/vector/VectorDemo.java)


# Set 接口和他的实现类 HashSet、TreeSet
>set是元素无序并且不可以重复的集合, Set 的底层实现是 Map

## Set 的特性 - 怎样比较两个元素是否相同
Set 接口的方法和 Collection 完全一致, 没有特有方法

#### 1. 比较两个对象是否相同的方法
HashSet 判断两个元素是否相同, 以及删除元素, 依靠的都是 `hashcode + equals`

## Set 的实现类 -- HashSet
> HashSet 底层数据结构是 哈希表, 线程非同步

1. HashSet中只允许一个null元素  
2. 具有良好的存取和查找性能  
4. HashSet的底层是哈希表,比较两个对象是否相同采用的是**hashCode + equals**  
5. hashset使用泛型消除安全隐患

### 1. HashSet 怎样保证元素的唯一性呢?  
> 通过 hashCode + equals

Set 集合的无序指的是存入的顺序和取出的顺序是不同的.

你存入对象的时候, HashSet 存入的是内存地址的哈希值, 并按照哈希值的大小排序.  

如果两个对象的哈希值相同(HashCode被重写的情况下), Set 集合会再比较一下两个对象的类型是否相同, 如果对象类型和哈希值都相同, 则存储失败.   

hashCode和equals方法用来提高查询速度，hashCode用来判断在哪个桶里，equals用来判断是桶里的哪个元素。  

### 2. 在HashSet中存放自定义类
set存放自定义类时, 编译器无法比较自定义类是否相同======>在该类中重写hashCode和equals方法。

[hashSet 在自定义类中重写hashcode和equals](https://github.com/EasterFan/JavaExercise/blob/master/SetProj/src/hashset/Pet_set.java)

## Set 的实现类 -- TreeSet
> TreeSet 底层实现是二叉树 -- 因为TreeSet每存入一个元素, 都要和集合中已有元素比较, 故使用二叉树快速比较, 节约时间

**TreeSet 进行排序的依据** 有两个:  
- 让对象实现`Comparable接口`, 使对象具有可比性
- 当对象自身不具备比较性, 或具备的比较性不是所需要的, 这时就需要让集合自身具备比较性

这两种比较方式,就好像体测身高的教室,   
第一种, 让对象具备比较性, 每个学生进入后, 自己和前面的同学比身高, 对象自己调整, 按身高排序,即学生对象自己拥有排序方法;  
第二种, 让集合具有比较性, 学生进入教室后, 教室拥有一个身高测量表, 自动采集学生身高数据, 进行排序.

### 1. 让对象具备比较性
> 自定义类实现 Comparable 接口, 并重写`CompareTo`方法, CompareTo 方法中定义二叉树存储规则, 1表示大数存右边, -1 表示小数存左边, 0 表示重复元素, 不存入

可以对集合中的元素进行排序, 往TreeSet中存储的对象必须具有**比较性**,使得 TreeSet 了解对象的排序规则    
怎样让对象具有比较性? -- 让对象实现 Comparable接口, 并重写 `CompareTo`方法即可  

CompareTo 返回值有三个(-1 左数, 1 右数), 0 表示重复对象, 插入失败.  

```java
// 学生对象的排序规则 -- 按照年龄排序
    @Override
    public int compareTo(Object obj) {
        if(!(obj instanceof Student))
            throw new RuntimeException("传入的不是学生类");
        Student stu = (Student)obj;

        // 判断主要条件和次要条件
        if(this.age > stu.age)
            return 1;
        // 当年龄相同的情况下(如果返回值为0,则记录存不进去), 应该再判断姓名, 按照姓名排序
        if(this.age == stu.age)
            return this.name.compareTo(stu.name);
        return -1;
    }
}
```
[让对象具备比较性](https://github.com/EasterFan/JavaExercise/blob/master/SetProj/src/treeset/treeSetPaiXu.java)  

TreeSet 保证数据唯一性的依据:  
**CompareTo return 0**  
TreeSet 在使用contains 包含和删除时,都会调用底层的CompareTo, 判断元素是否存在

那么怎样实现, TreeSet 怎样存入,就怎样取出呢(不按照大小顺序排序)?  
- 只需要在重写`CompareTo方法`时, 直接`return 1` 或 `return -1`即可

### 2. 让集合具有比较性
> 在创建 TreeSet 集合时,传入比较器, 使容器具备比较性

当对象比较性和容器比较性同时存在时,  
容器比较性会覆盖对象比较性;  

开发中容器比较性更为常用.

容器比较性的实现 -- 实现Comparator 接口, 重写 compare 方法  
```java
class MyComparator implements Comparator{

    @Override
    public int compare(Object o, Object t1) {
        Student2 stu1 = (Student2) o;
        Student2 stu2 = (Student2) t1;

        // 按照姓名排序
        int num = stu1.getName().compareTo(stu2.getName());
        // 如果姓名相同, 按照年龄排序
        if(num == 0){
            if(stu1.getAge() > stu2.getAge())
                return 1;
            if(stu1.getName() == stu2.getName())
                return 0;
        }
        return num;
    }
}
```
[让集合具备比较性](https://github.com/EasterFan/JavaExercise/blob/master/SetProj/src/treeset/TreeSetOrderByCollection.java)  
[练习: 根据字符串长度进行排序](https://github.com/EasterFan/JavaExercise/blob/master/SetProj/src/treeset/StringTreeSetDemo.java)

# Map 接口和他的实现类
> map 集合(双列集合) 和 Collection 集合(单列集合)并列

Map 集合特点 : 该集合存储键值对, 键具有唯一性, 值可以重复  

Map 三个实现类: HashTable  HashMap  TreeMap  

## Map 集合的共性和特性方法

### 1. Map 共性方法
- 添加
  - put(K key, V value)  -- 返回原来的值(键相同时(通过重写hashcode和equals判断键是否相等), 新值覆盖旧值)
  - putAll(Map<? extends K,? extends V> m)

- 删除
  - clear()
  - remove(Object key)

- 判断
  - containsKey(Object key)
  - containsValue(Object value)
  - isEmpty()

- 获取
  - get(Object key)
  - size()
  - values()
  - **entrySet()**
  - **keySet()**


### 2. Map 特性方法
> Map 没有迭代器(其键值对存储方式,不需要迭代), 有两种方式取出所有元素: map --> Set --> Iterator

方法一:  keySet()   
```java
Set<String> key = map.keySet();
        for(Iterator<String> it = key.iterator();it.hasNext();){
            String key1 = it.next();
            String value = map.get(key1);
            System.out.println(key1 +"...."+ value);
        }
```

方法二: entrySet() -- 将Map中的**映射关系**取出, 存入到 Set 集合中
```java
   Set<Map.Entry<String,String>> mapentry = map.entrySet();

        for(Iterator<Map.Entry<String,String>> it = mapentry.iterator();it.hasNext();){
            Map.Entry<String,String> me = it.next();

            String entrykey = me.getKey();
            String entryvalue = me.getValue();
            System.out.println("key: "+ entrykey + ",value: " + entryvalue);
        }
```
`map.entrySet`返回的是一个 Set 集合, 集合里面盛放的是 map 集合的映射关系, 每一个映射关系的数据类型是:`Map.Entry`类型.  

`Entry`是map的内部接口,所以用`Map.Entry`调用  
[两种方式遍历map](https://github.com/EasterFan/JavaExercise/blob/master/MapProj/src/map/MapFunc.java)

## Map 实现类 HashTable
> 底层实现 -- 哈希表 , 不允许 null 作为键或值, 该集合线程同步, jdk1.0, 效率低

## Map 实现类 HashMap
> 底层实现 -- 哈希表 , 允许 null值 和 null键, 该集合线程不同步, jdk1.2, 效率高

同 HashSet 一样, HashMap的存储是无序的, 通过重写 `Hashcode + equals`判断集合元素的唯一性.  
[HashMap - 对学生的无序存取](https://github.com/EasterFan/JavaExercise/blob/master/MapProj/src/hashmap/MapTest.java)

##  Map 实现类 TreeMap
> 底层实现 -- 二叉树, 不同步, 可以对 map 集合中的键排序

同TreeSet一样, TreeMap 有两种方式,实现对键的排序:  
- 让对象实现`Comparable`接口, 重写`CompareTo`方法, 使对象具有比较性
- 让集合实现`Comparator`接口,重写`compare`方法, 使集合具有比较性


[TreeMap - 对学生的有序存取](https://github.com/EasterFan/JavaExercise/blob/master/MapProj/src/treemap/TreeMapTest.java)  
[TreeMap练习 -- 数字母数](https://github.com/EasterFan/JavaExercise/blob/master/MapProj/src/treemap/TreeMapCountNum.java)

## Map 集合的扩展
> map 存储 map

Map 集合存储的是一对一的映射关系, 但是, Map 也可以存储一对多的关系 --- 在 Map 中存入集合.  
Map 集合的扩展使用, 体现在数据库一对多的表结构中

一个学校, 对应多个班级, 一个班级,对应多个学生, 每个学生学号对应一个姓名
[Map 扩展 - Map 存 Map](https://github.com/EasterFan/JavaExercise/blob/master/MapProj/src/map/MapInMap.java)  
一个学校, 对应多个班级, 一个班级,对应多个学生对象, 每个学生对象里有学号和姓名属性    
[Map 扩展 - Map 存 set](https://github.com/EasterFan/JavaExercise/blob/master/MapProj/src/map/ListInMap.java)
