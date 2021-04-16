



## 1. 谈谈 HashMap 的底层实现？
> HashMap 扩容机制 、死循环、 hash 冲突


### 一. 简介 - 数组、链表、红黑树的区别
> 数组的优缺点？ 链表的优缺点？ 散列表的特点？ 什么是哈希？

数组查询快，增删慢，大小是固定的，在内存中是连续的  
链表查询慢，增删快

散列表 = 数组 + 链表

哈希的定义：把任意长度的输入，通过哈希算法，变成固定长度的输出。输出的二进制串就是哈希值。
hash 的特点：
- 哈希是用来寻址的
- 从hash值不可以反向推导出原始的数据
- 输入数据的微小变化会得到完全不同的 hash 值，相同的数据会得到相同的值
- hash 算法的执行效率很高效，长的文本也可以快速的计算 hash 值
- hash 算法的冲突概率非常小

出现 hash 冲突时，如果是key值相同引起的冲突，则停止put操作，如果是 key 值不同，哈希冲突的话，会在冲突的数组节点处，使用尾插法形成链表结构，当链表长度到达8的时候，链表结构转为红黑树


为什么会出现 hash 冲突？  
因为 hash 的原理是将输入空间的值映射成 hash 空间内，而 hash值的空间远小于输入的空间，根据抽屉原理，一定会存在不同的输入被映射成相同输出的情况。

抽屉原理：桌上有10个苹果，要把这10个苹果放到9个抽屉里，无论怎样放，都会发现，至少有一个抽屉里面放了不少于两个苹果，这一现象就是“抽屉原理”。

### hashmap底层储存结构图解
> 底层结构其实就是数组+链表+红黑树
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20210303163411.png)

数组默认长度是16，当链表长度>8 && 整个hash表中元素扩容达到64个元素时，链表变红黑树

put 方法的过程：  
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20210309165238.png)  

hashMap 中链表很长的时候，get(key)方法低效，为了解决 hashmap 链化很长，降低了查找效率，故引入了红黑树。

当调用 remove 方法，链表长度小于6时，树降级成链表


### hashmap 的扩容
> 扩容的目的是为了用空间换时间，提高查询效率 - resize 方法是核心

负载因子默认是0.75，即元素数量达到3/4 时，开始扩容，不建议改



参考：

[视频](https://www.bilibili.com/video/BV1LJ411W7dP?p=2&spm_id_from=pageDriver)

https://gitee.com/gu_chun_bo/java-construct/blob/d466640dc977a61433fecbbb069ffe7a56d46d1a/java%E9%9B%86%E5%90%88/HashMap.md

https://gitee.com/SnailClimb/JavaGuide/blob/master/docs/java/collection/HashMap(JDK1.8)%E6%BA%90%E7%A0%81+%E5%BA%95%E5%B1%82%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84%E5%88%86%E6%9E%90.md



## 2. 谈谈 ArrayList 和 LinkedList 的区别？
