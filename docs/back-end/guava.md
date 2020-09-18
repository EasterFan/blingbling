# Guava
Guava 是一个常用的 java 库，包含常用的集合、缓存、原生类型支持、并发库、通用注解、字符串处理、IO 等。

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200917153058.png)

## 一.怎样判空
因为 java8 中已经引进了 Optional，所以就没必要使用 guava 的判空操作了。此部分参见 java8 - Optional

## 二. 不可变集合
> 创建对象的**不可变拷贝**是一项很好的**防御性编程**技巧

不可变对象的优点：
- 当对象被不可信的库调用时，不可变形式是安全的
- 不可变对象被多个线程调用时，不存在竞态条件问题
- 不可变集合不需要考虑变化，因此可以节省时间和空间。所有不可变的集合都比它们的可变形式有更好的内存利用率（分析和测试细节）；
- 不可变对象因为有固定不变，可以作为常量来安全使用。

创建对象的不可变拷贝是一项很好的防御性编程技巧。Guava为所有JDK标准集合类型和Guava新集合类型都提供了简单易用的不可变版本。
JDK也提供了Collections.unmodifiableXXX方法把集合包装为不可变形式，但我们认为不够好：

- 笨重而且累赘：不能舒适地用在所有想做防御性拷贝的场景；
- 不安全：要保证没人通过原集合的引用进行修改，返回的集合才是事实上不可变的；
- 低效：包装过的集合仍然保有可变集合的开销，比如并发修改的检查、散列表的额外空间，等等。

如果你没有修改某个集合的需求，或者希望某个集合保持不变时，把它防御性地拷贝到不可变集合是个很好的实践。

### 创建不可变集合
```java
// 1. copyOf 方法： 通过已存在的集合创建
ImmutableSet immutableSet = ImmutableSet.copyOf(list);
// 2. of 方法
ImmutableSet<Integer> immutableSet1 = ImmutableSet.of(1, 2, 3);
// 3. Builder 工具
ImmutableSet<Integer> immutableSet2 = ImmutableSet.<Integer>builder()
                .add(4)
                .addAll(immutableSet1)
                .add(5)
                .build();
```

## 三. 新集合类型
> 为了开发方便， Guava 中引入了一些 JDK 没有的，但明显有用的新集合类型， 这些集合和 JDK 集合框架共存，而没有新增加概念
### 1. Multiset = Set + List
> Set = 无序 + 不可重复， List = 有序 + 可重复， Multiset = 无序 + 可重复

Multiset = 没有元素顺序限制的 ArrayList
         = 可以重复的 Set
