<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [java8 新特性 - Lambda 表达式](#java8-新特性---lambda-表达式)
  - [一. 函数式编程](#一-函数式编程)
  - [二. Lambda 表达式](#二-lambda-表达式)
    - [1. Lambda 表达式的形式](#1-lambda-表达式的形式)
    - [2. 函数式接口](#2-函数式接口)
    - [3.方法引用](#3方法引用)
  - [三. Stream 流操作](#三-stream-流操作)
    - [Filter](#filter)
    - [Map](#map)
    - [flatMap](#flatmap)
    - [peek](#peek)
    - [sort 排序](#sort-排序)
    - [distinct 去重](#distinct-去重)
    - [skip](#skip)
    - [limit](#limit)
    - [allMatch / anyMatch / nonMatch](#allmatch--anymatch--nonmatch)
    - [findFirst / findAny](#findfirst--findany)
    - [max / min / count](#max--min--count)
    - [reduce](#reduce)
    - [collect](#collect)
    - [Optional 使用](#optional-使用)
    - [流的构建](#流的构建)
  - [一个栗子看函数式编程演化的历程](#一个栗子看函数式编程演化的历程)
  - [参考](#参考)
<!-- TOC END -->

# java8 新特性 - Lambda 表达式


> java 8 语法新特性 - 函数式编程、Lambda 表达式，Stream 流操作

## 一. 函数式编程
函数式编程式一种编程思想，和面向对象，面向过程并列的编程标准。
- 函数是一等公民（就像面向对象里，万物皆对象），
- 函数可以赋值给变量，也可以作为参数和返回值
- Lambda 表达式是 java 在函数式编程的实现方式  

为什么要引入Lambda？  
因为在java之后，出现了 Scala，Kotlin 这样的多范式语言开始流行起来，java 作为纯面向对象的语言遇到了挑战，所以在 java8 中推出 Lambda。  

Lambda 一个主要的特点是**通过行为参数化传递代码**，在此之前，java 中数据的传递是依赖对象或匿名内部类实现的。


## 二. Lambda 表达式
### 1. Lambda 表达式的形式

- 可以不写参数类型，编译器可以自己识别参数值
- 多个参数圆括号，一个参数不需要括号

```java
// 无参
() -> System.out.println("no args");

// 1 个参数
name -> System.out.println("1 args" + name);

// 无参，但逻辑复杂
() -> {System.out.println("no args1");
      System.out.println("no args2");}

// 2个参数，不显式声明类型，由 Lambda 根据上下文自己推断
Double calculateSum = (x,y) -> x + y;
Float result = calculateSum(1F, 2F);

// 2 个参数，显式指定类型
Double calculateSum = (Float x, Float y) -> x + y;
Float result = calculateSum(1F, 2F);
```

### 2. 函数式接口
#### 是什么
为了让现有函数更好的支持 Lambda，java 语言设计者们引入了函数式接口的概念。  

**“函数式接口”是指只包含一个抽象方法，但是可以有多个非抽象方法，像这样的接口，可以被隐式地准换成Lambda表达式。**  

与函数式接口同步的，java8 新增了一个接口注解`@FunctionInterface`,表明这个接口是一个函数式接口，最好在函数式接口上标注这个注解，这样我们在多写了抽象方法后，编辑器会直接报错提醒。通常，如果一个接口只有一个抽象方法，编辑器会自动判断这个接口为函数式接口。

注：大部分函数式接口都不用我们自己写，Java8都给我们实现好了，这些接口都在java.util.function包里。


举个栗子：  
```java
@FunctionalInterface
public interface Converter<F, T> {
  T convert(F from);
}
```

```java
// 将数字字符串转换为整数类型
Converter<String, Integer> converter = from -> Integer.valueOf(from);
Integer converted = converter.convert("123");
System.out.println(converted.getClass()); //class java.lang.Integer
```


#### 常用的函数式接口
我们也可以根据业务需要自定义函数式接口，但是我们自定义的接口比如传入的参数 Product 还是太具象，不够抽象，java8 里定义了几种常用函数式接口，可以直接调用。

```java
public interface ProductPredicate {
    boolean test(Product product);
}
```

| 接口              | 参数  | 返回类型 | 作用                                                           |
| ----------------- | ----- | -------- | -------------------------------------------------------------- |
| Predicate<T>      | T     | boolean  | 用于判别一个对象，比如求一个人是否为男性                       |
| Function<T,R>     | T     | R        | 用于转换一个对象为不同类型的对象                               |
| Consumer<T>       | T     | void     | 接收一个对象进行处理，但没有返回，比如接收一个人并打印他的名字 |
| Supplier<T>       | void  | T        | 提供一个对象                                                   |
| UnaryOperator<T>  | T     | T        | 接收对象并返回同类型的对象                                     |
| BinaryOperator<T> | (T,T) | T        | 接收两个同类型的对象并返回一个原类型对象                       |


##### Predicate<T>
```java
public static void main(String[] args) {
    //接收一个泛型参数，比较返回boolean值
    Predicate<Integer> predicate = age -> age == 1;

    System.out.println(predicate.test(1));//true
    System.out.println(predicate.test(2));//false
}
```

##### Function<T,R>

##### Consumer

##### Supplier

### 3.方法引用
类似于这样的使用 `::` 写法，就是 Lambda 的方法引用。  
**方法引用就是通过类调用特定方法，可以让你重复使用现有的方法定义，并像 Lambda 表达式一样传递它们，本质上是 Lambda 表达式的一种快捷写法。**

```java
Optional.ofNullable(line)
        .map(List::stream)
        .orElseGet(Stream::empty)
        .sorted(Comparator
                .comparing(Product::getTotalPrice))
        .forEach(resultProductList::add);
```
Lambda 的方法引用主要分为三种：

#### 指向静态方法的方法引用
当 Lambda 表达式结构体是一个对象调用它的静态方法时，可以使用方法引用

```java
/**
 * (args) -> ClassName.staticMethod(args);
 * ClassName::staticMethod
 */
public void test1() {
  // 内部实例对象调用内部静态方法
    Consumer<String> consumer1 = (String name)-> System.out.println(name);  
    Consumer<String> consumer2 = System.out::println;
}
```
#### 指向任意类型实例方法的方法引用

```java
/**
 * (args) -> args.instanceMethod();
 * ClassName::instanceMethod
 */
public void test2() {
  // 内部实例对象调用内部自己的实例方法
    Consumer<Product> consumer1 = (Product product) -> product.getProductName();

    Consumer<Product> consumer2 = Product::getProductName;
}
```

#### 指向现有对象的实例方法的方法引用
```java
/**
 * (args) -> object.instanceMethod(args);
 * object::instanceMethod
 */
public void test3() {
  // stringBuilder 是外部实例对象调用外部自己的方法，对参数进行操作
    StringBuilder stringBuilder = new StringBuilder();

    Consumer<Product> consumer1 = (Product product) -> stringBuilder.append(product);

    Consumer<Product> consumer2 = stringBuilder::append;
}
```

## 三. Stream 流操作
Stream 流是：  
- JDK1.8 引入的新成员，以声明式方式处理集合数据
- 将基础操作链接起来，完成复杂的数据处理流水线
- 提供透明的并行处理

流与集合的区别：  
- **集合面向存储，流面向计算**，听到一个很生动的关于集合和流的例子，集合就像DVD，需要把整个光碟放到播放器里才可以听歌，流就像流媒体，我们不需要把整部电影加载完，只需要加载当前要看的一部分，边下边看。

- 集合可以遍历多次，但流只可以遍历一次（再次遍历会出现异常）
- 外部迭代与内部迭代（集合是一个迭代生成一个新集合，流是多个迭代操作后生成一个集合）

一个流是由三部分组成的，**数据源、中间操作、终端操作**，在执行完终端操作后流就关闭了，终端操作后不可以再进行中间操作    
```java
List result = cartList.stream()
        // 打印所有商品
        .peek(product -> System.out.println(JSON.toJSONString(product, true)))
        // 过滤留下符合条件的项
        .filter(product -> !ProductCategoryEnum.BOOKS.equals(product.getProductCategory()))
        // 按照总价格排序
        .sorted(Comparator.comparing(Product::getTotalPrice).reversed())
        // 取前两个
        .limit(2)
        // 计算总价
        .peek(product -> money.set(money.get() + product.getTotalPrice()))
        // 取出名字
        .map(Product::getProductName)
        .collect(Collectors.toList());
```
- 数据源：通常是集合  
- 中间操作：
  - 无状态操作：peek filter map    
  - 有状态操作：dictinct/sorted/limit..
- 终端操作：
  - 非短路操作：collect/forEach/count
  - 短路操作：anyMatch/findFirst/findAny

![流的分类](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/2020-02-12%20at%2018.55.png)  

中间操作有无状态的区别，就像写 SQL 查询一样，像去重，排序这样的操作需要在查询所有数据后进行操作，Stream 流里的有状态是指流中所有元素都执行完了，才可以进行的中间操作，无状态是指不需要流中的元素全部完成，就可以执行的中间操作。

有状态和无状态对数据执行的顺序有影响。  

终端操作的短路是指遍历到流中某个特殊元素后，就停止遍历了（有一部分流中元素就没有被遍历到），非短路是指流中所有元素都会被遍历到。  

### Filter
```java
cartList.stream()
              // 过滤：留下符合条件的，去掉不符合的 - 判断 Predicate
              .filter(product -> ProductCategoryEnum.BOOKS.equals(product.getProductCategory()))
              .forEach(product -> System.out.println(JSON.toJSONString(product, true)));
```

### Map
```java
cartList.stream()
             // 映射：将一个元素转换成另一个元素 - 转换 Function
             .map(product -> product.getProductName())
             .forEach(product -> System.out.println(JSON.toJSONString(product, true)));
```

### flatMap
flatMap 是 Map 的特殊形式，用于嵌套结构的数据。  
```java
cartList.stream()
        // 扁平化：将一个元素转换成另一个元素,并拍平输出 - 转换 Function
        .flatMap(product -> Arrays.stream(product.getProductName().split("")))
        .forEach(product -> System.out.println(JSON.toJSONString(product, true)));
```
Map 和 flatMap 的区别：  
```java
<R> Stream<R> map(Function<? super T, ? extends R> mapper);
<R> Stream<R> flatMap(Function<? super T, ? extends Stream<? extends R>> mapper);
```
从对数据的处理方面看，  
```java
// map [ ...['y', 'o', 'u', 'r'], ['n', 'a', 'm', 'e']]
[a,b,c] f(x) => [f(a),f(b),f(c)]

// flatMap
[[a,b],[c,d,e]] f(x) =>[f(a),f(b),f(c),f(d),f(e)]
```

从对流的处理方面看，
Map: 将一种类型的值转化成另外一种类型的值 - 流对象还是原来的流对象  
flatMap：先将元素映射成流，再将多个Stream连接成一个Stream，这时候不是用新值取代Stream的值，与map有所区别，这是重新生成一个Stream对象取而代之 - 流对象是新的流对象

### peek
流式编程不方便调试，peek 方法一个常用场景是调试打印出，查看每次映射后是个啥样。
```java
cartList.stream()
               // 遍历：中间操作 - 消费 Consumer
               .peek(product -> System.out.println(product.getProductName()))
               .forEach(product -> System.out.println(JSON.toJSONString(product, true)));
```
```bash
> Task :compileTestJava
> Task :processTestResources NO-SOURCE
> Task :testClasses
> Task :test
helicopter
{
	"productCategory":"ELECTRONICS",
	"productId":110,
	"productName":"helicopter",
	"productPrice":100,
	"totalNum":1,
	"totalPrice":100
}
iphone
{
	"productCategory":"ELECTRONICS",
	"productId":120,
	"productName":"iphone",
	"productPrice":200,
	"totalNum":2,
	"totalPrice":400
}
t-shirt
```

peek 和 foreach 的区别：  
peek 和 foreach 都是对流遍历，peek 是中间操作，foreach 是终端操作，foreach 操作完后这个流就不可用了，但是 peek 操作完后别的流还可以用。

在上面例子中，peek 和 foreach 是交替运行的，并不是说一条流先在 peek 运行结束再运行 foreach，其实出现这个状况是因为 peek 是一个无状态的中间操作，所以 **元素【是元素，不是流！】** 先执行 peek 中间操作，再执行 foreach 终端操作，就出现了交替运行的状况，如果中间操作是有状态的，那么流就会按顺序执行。  

### sort 排序
单字段排序：
```java
cartList.stream()
                // 排序：中间操作 - 比较 Comparator，默认升序
                .sorted(Comparator.comparing(Product::getTotalPrice))
                .forEach(product -> System.out.println(JSON.toJSONString(product, true)));

// 降序一：按照商品总价直接降序 - 推荐
list.stream().sorted(Comparator.comparing(Product::getTotalPrice, Comparator.reverseOrder()));

// 降序二：按照商品总价升序后，再逆序
list.stream().sorted(Comparator.comparing(Product::getTotalPrice).reversed());

// 多字段组合：先按照商品总价升序后，再按照商品单价升序
list.stream().sorted(Comparator.comparing(Product::getTotalPrice).thenComparing(Product::getPrice));

// 多字段组合：属性一降序后，属性二降序
list.stream().sorted(Comparator.comparing(类::属性一, Comparator.reverseOrder()).thenComparing(类::属性二, Comparator.reverseOrder()));

// 多字段组合：属性一升序后，属性二降序
list.stream().sorted(Comparator.comparing(类::属性一).thenComparing(类::属性二,Comparator.reverseOrder()));

// 多字段组合：属性一降序，属性二升序
list.stream().sorted(Comparator.comparing(类::属性一, Comparator.reverseOrder()).thenComparing(类::属性二));
```

### distinct 去重
```java
cartList.stream()
                .map(Product::getProductCategory)
                // 去重：对产品的种类进行去重 - 比较 Comparator
                .distinct()
                .forEach(product -> System.out.println(JSON.toJSONString(product, true)));
 // 根据单个字段名去重
 list.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() -> new TreeSet<>(Comparator.comparing(Product::getName))), ArrayList::new))

 // 根据多个字段名去重、
 list.stream()
        .collect(Collectors.collectingAndThen(Collectors.toCollection(() ->
        new TreeSet<>(Comparator.comparing(o -> o.getBrand() + ";" + o.getCarModel()))), ArrayList::new));

```
distict 不可传参（根据传入参数进行去重），需要先对数据进行 map 等处理，再直接 distinct

### skip
```java
cartList.stream()
                .map(Product::getProductCategory)
                // 过滤：过滤前3条数据
                .skip(3)
                .forEach(product -> System.out.println(JSON.toJSONString(product, true)));
```
### limit
```java
cartList.stream()
         .map(Product::getProductCategory)
         .skip(2 * 3)
         // 过滤：只取集合中的前 3 条数据
         .limit(3)
         .forEach(product -> System.out.println(JSON.toJSONString(product, true)));
```
注： skip + limit 可以对集合实现一个简易的分页操作  

### allMatch / anyMatch / nonMatch
检查数组中的元素是否符合要求时，很常用！并且这三个都是短路的终端操作，如果遍历到一个符合/不符合的元素，就会马上中止流操作，返回 boolean 值。   
```java
boolean match = cartList.stream()
        // 检查流中元素是否都满足某个条件，都满足 -> true, 不都满足 -> false
        .allMatch(product -> product.getTotalPrice() > 100);
System.out.println(match);
```
```java
boolean match = cartList.stream()
        // 检查流中元素是否有一个满足某个条件，任意一个满足 -> true, 都不满足 -> false
        .allMatch(product -> product.getTotalPrice() > 100);
System.out.println(match);
```
```java
boolean match = cartList.stream()
        // 检查流中元素所有元素都不满足，所有元素都不满足 -> true, 有一个满足 -> false
        .noneMatch(product -> product.getTotalPrice() > 100);
System.out.println(match);
```
### findFirst / findAny
findFirst 和 findAny 最大的区别是在并行上，findAny 比 findFirst 更快，但 findAny 缺点是每次返回的值都是随机的不固定，在串行上二者速度相当。  

```java
Optional optional = cartList.stream()
            //  返回第一个
            .findFirst();
System.out.println(JSON.toJSONString(optional.get(), true));
```

```java
Optional optional = cartList.stream()
        //  只要有就返回
        .findAny();
System.out.println(JSON.toJSONString(optional.get(), true));
```

### max / min / count
> 求最大、最小、和、平均数
```java
//最大值
double max = cartList.stream().mapToDouble(Product::getProductPrice).max().getAsDouble();

// 平均数
double average1 = list.stream().mapToLong(User::getAge).average().getAsDouble();
double average2 = list.stream().collect(Collectors.averagingLong(User::getAge));

// 求和
double sum = list.stream().mapToLong(User::getAge).sum();

// 计算总数
long count = cartList.stream().count();
```

### reduce
Reduce 意为：减少、缩小。通过入参的 Function，我们能够将 list 归约成一个值。它的返回类型是 Optional 类型。  
```java
Optional name = cartList.stream()
        .map(Product::getProductName)
        .reduce((n1, n2) -> n1 + n2);
//如果Optional为空，返回一个默认的姓名
name.orElse("default name");
name.ifPresent(System.out::println);
```

### collect
collect 是一个终端操作，意为聚合，在流中扮演的角色是流的**收集器**，将流中的元素累积成一个结果  

几个区分的概念：  
- collect 终端方法
- Collector 接口，collect 方法需要接收一个实现了 Collector 接口的收集器
- Collectors  工具类，帮我们封装了一些已经实现了 Collector 的收集器，可以直接拿过来用  

在内置的 collect 收集器中，collect 主要有三个功能：  
- 将流元素归约和汇总为一个值(List / Set / Map)
- 将流元素分组
- 将流元素分区

```java
 // Map<分类条件，结果集合>
Map<Double, List<Product>> productsByPrice = cartList
               .stream()
               // 根据商品单价分组
               .collect(Collectors.groupingBy(p -> p.getProductPrice()));

       productsByPrice
               .forEach((price, p) -> System.out.format("price %s: %s\n", price, p.get(0).getProductName()));
```

可以通过`summarizing collectors`能返回一个内置的统计对象，通过这个对象能够获取更加全面的统计信息，比如商品单价中的最大值，最小值，平均值等结果。
```java
DoubleSummaryStatistics phrase = cartList
        .stream()
        .collect(Collectors.summarizingDouble((Product p) -> p.getProductPrice()));
System.out.println(phrase);
// DoubleSummaryStatistics{count=5, sum=420.000000, min=10.000000, average=84.000000, max=200.000000}
```

下面的例子展示如何将所有商品名连接成一个字符串：  
```java
// 拼接字符串
// In this cart, helicopter and iphone and t-shirt and javaBook and soccer will come to you soon.
String phrase2 = cartList
        .stream()
        .map(Product::getProductName)
        .collect(Collectors.joining(" and ","In this cart, "," will come to you soon."));

System.out.println(phrase2);

// joining
String join = emps.stream().map(Employee::getName).collect(Collectors.joining());
// 添加连接
String join1 = emps.stream().map(Employee::getName).collect(Collectors.joining("-"));
// 添加前缀和后缀还有连接
String join2 = emps.stream().map(Employee::getName).collect(Collectors.joining("-", "{", "}"));
```

将一个stream转换为map，我们必须指定map的key和value如何映射。要注意的是key的值必须是唯一性的，否则会抛出IllegalStateException，但是可以通过使用合并函数（可选）绕过这个IllegalStateException异常：  

```java
// Stream 转 map
Map<String, Double> map = cartList
        .stream()
        .collect(Collectors.toMap(
                Product::getProductName,
                Product::getProductPrice));

System.out.println(map);
```

将流元素分区  
```java
// 分区是分组的一个特例 Map<Boolean，结果集合>
Map<Boolean, List<Product>> partition = cartList.stream()
        .collect(Collectors.partitioningBy(product -> product.getTotalPrice() > 200));
System.out.println(JSON.toJSONString(partition, true));
```

### 流的构建
流的构建有四种构建形式。  

- 由值创建流
of 静态方法可以接收任意数量的参数，显式的创建流
- 由数组创建流
- 由文件生成流
- 由函数生成流（无限流）

```java

    /**
     * 1.由数值直接构建流
     */
    @Test
    public void streamFromValue() {
        Stream stream = Stream.of(1, 2, 3, 4, 5);
        stream.forEach(System.out::println);
    }

    /**
     * 2. 通过数组构建流
     */
    @Test
    public void streamFromArray() {
        int[] numbers = {1, 2, 3, 4, 5};

        // 根据传入的数组的类型，返回不同的包装类
        IntStream stream = Arrays.stream(numbers);
        stream.forEach(System.out::println);
    }

    /**
     * 3. 通过文件构建流
     *
     * @throws IOException
     */
    @Test
    public void streamFromFile() throws IOException {
        Stream<String> stream = Files.lines(Paths.get("/Users/easterfan/Desktop/java8functionalProgramming/src/test/java/stream/StreamNew.java"));
        stream.forEach(System.out::println);
    }


    /**
     * 4. 通过函数生成流（无限流）
     * 迭代是在原来的流上迭代生成
     * generate 生成的流不会基于上一个流，而是随机生成的流
     */
    @Test
    public void streamFromFunction() {
        Stream stream1 = Stream.iterate(0, n -> n + 2);
        Stream stream2 = Stream.generate(Math::random);
        stream1.limit(100)
                .forEach(System.out::println);
    }
```

## 四. Optional 使用
为什么要用？ - clean code(判空操作带来的防御式检查) 和 避免空指针

### 创建 Optional 对象
```java
// 声明一个空的 Optional
Optional<Car> optCar = Optional.empty();

// 根据一个非空值创建 Optional - 使用静态工厂方法 Optional.of - 如果car是一个null，这段代码会立即抛出一个NullPointerException，而不是等到你 试图访问car的属性值时才返回一个错误。
Optional<Car> optCar = Optional.of(car);

// 可接受null的Optional - 如果car是null，那么得到的Optional对象就是个空对象
Optional<Car> optCar = Optional.ofNullable(car);

```

建议：
- 避免使用基础类型的 Optional 对象，即避免使用Optional<Integer>, Optional<Double>,而是直接返回：OptionalInt,OptionalDouble

### 从 Optional 对象中提取和转换值


## 一个栗子看函数式编程演化的历程
比如一个对购物车中商品进行筛选的例子。  

一个购物车中有数码，衣服，书籍等类别的商品。  
需求1：从购物车中筛选出所有的数码商品。 - 输入：购物车商品列表（数码这个类别被写死到代码中）  
需求2：根据用户输入的商品类别。筛选出购物车中对应的商品。 - 输入：所有商品的枚举类 + 购物车商品列表（可扩展，更加灵活）  
需求3:  从购物车中筛选出所有 1000元以下的衣服商品。  

函数式编程演化历程：  
1. 将业务逻辑直接写死在代码里。
```java
// 需求1：找出购物车中所有电子产品
public static List<Product> getAllElectricProduct(List<Product> cartList) {
  // logic 参数写死在逻辑里
    return cartList;
}
```
2. 将单一维度的条件作为参数传入方法中，方法内根据参数进行业务逻辑实现（商品类型枚举类）  
```java
// 需求2：购物车中某种类型的商品有哪些
public static List<Product> getSpecificProductByCategory(ProductCategoryEnum productCategoryEnum, List<Product> cartList) {
    // logic 参数从 ProductCategoryEnum 中获得
    return cartList;
}
```

3. 将多个维度的条件作为参数传入方法中，业务实现需要根据不同的参数，处理不同逻辑（商品类型枚举类，商品发货地枚举类等）。  
```java
// 需求3：购物车中某种类型 发货地来源类型 的商品有哪些
public static List<Product> getSpecificProductByCategory(ProductCategoryEnum productCategoryEnum, ProductFromAddressEnum productFromAddressEnum, List<Product> cartList) {
    // logic 参数从 ProductCategoryEnum 中获得
    return cartList;
}
```

4. **【面向对象】**：将业务逻辑封装为一个实体类接口，方法接收实体类为参数，方法内部调用实体类的处理逻辑(策略模式)。  

接口中是把对商品不同的过滤条件封装起来，然后在运行时根据传入的不同过滤条件来进行业务逻辑处理。
封装的接口类：  
```java
public interface ProductPredicate {
    boolean test(Product product);
}
```

实现的接口类：  
```java
/**
 * 对商品总价是否超出200作为判断标准
 */
public class ProductTotalPricePredicate implements ProductPredicate {
    @Override
    public boolean test(Product product) {
        return product.getTotalPrice() > 200;
    }
}
```

service 层：  

```java
// 需求3：根据不同的product判断标准，对cartList列表进行过滤
public static List<Product> getSpecificProduct(List<Product> cartList, ProductPredicate productPredicate) {
    List<Product> result = new ArrayList<>();

    for (Product product : cartList) {
        // 判断是否符合过滤标准
        if (productPredicate.test(product)) {
            result.add(product);
        }
    }
    return result;
}
```

test 文件调用处：  
```java
@Test
public void should_filter_product(){
    List<Product> result = CartService.getSpecificProduct(cartList,new ProductTotalPricePredicate());
}
```

5. 调用方法时不再创建实体类，是使用匿名函数的形式替代。  
因为判断商品总价是否超出2000只需要调用一次，所以在调用处 test 文件中可以用匿名类替代，不需要新建一个 `ProductTotalPricePredicate` 类。  
```java
// 匿名类等价写法
List<Product> result2 = CartService.getSpecificProduct(cartList, new ProductPredicate() {
    @Override
    public boolean test(Product product) {
        return product.getTotalPrice() > 200;
    }
});
```

6. **【面向过程】**使用 Lambda 表达式替代匿名函数的形式，作为方法的参数，真正实现**判断逻辑参数化传递**。
```java
// Lambda 等价写法
List<Product> result3 = CartService.getSpecificProduct(cartList,
        (Product product) -> product.getTotalPrice() > 200);
```

## 参考
- [java8 tutorial - https://github.com/winterbe/java8-tutorial](https://github.com/winterbe/java8-tutorial)
- [java8 tutorial 中文翻译 - https://github.com/weiwosuoai/java8_guide](https://github.com/weiwosuoai/java8_guide)
- [干货 | Java8 新特性教程 - https://juejin.im/post/5c3d7c8a51882525dd591ac7](https://juejin.im/post/5c3d7c8a51882525dd591ac7)
