# 怎样写出优雅代码 - Lombok

> 拯救强迫症神器 - 一款用于简化代码的 IDEA 插件

# 介绍
## 开启 lombok 设置

开启这两个选项是为了让 lombok 注解在编译阶段起作用  
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20200207195035122.png)

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20200207195117268.png)

## 项目中引入 lombok
build.gradle  
```gradle
plugins {
    id "io.franzbecker.gradle-lombok" version "3.2.0"
  }
```
## Lombok 原理
如图，Lombok 的作用阶段是从 .java 文件到 .class 文件，动态的修改AST，增加新的节点（Lombok 自定义注解所需要生成的代码），然后再生成 JVM 所能运行的字节码文件。
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/markdown-img-paste-20200208092223373.png)


# 常用注解
## @Getter / @Setter /

## @RequiredArgsConstructor  
消灭 `@Autowired`

```java
public class TeacherService {
    @Autowired
    private RequestValidator requestValidator;

    @Autowired
    private PasswordService passwordService;

    @Autowired
    private UserService userService;
  }

// => after
@RequiredArgsConstructor(onConstructor = @__(@Autowired))
public class TeacherService {
    private final RequestValidator requestValidator;
    private final PasswordService passwordService;
    private final UserService userService;
  }
```

## @Builder
```java
User user = User.builder()
            .id(1)
            .name("aaa")
            .password("bbb")
            .build();
```
### @Builder 默认值问题
如果实体类中有默认值，@Builder 需要在实体类中使用 `@Builder.Default` 并赋值

## @Builder 和 @NoArgsConstructor 同时使用的报错
因为 @Builder 会自动创建全参构造器，添加 `@NoArgsConstructor` 后就不会自动产生全参构造器，解决方法就是加上 `@AllArgsConstructor`。

最后一个类往往是这样的
```java
@Setter(AccessLevel.PUBLIC)
@Getter(AccessLevel.PROTECTED)
@EqualsAndHashCode(callSuper = true)
@Builder
@AllArgsConstructor
public class User {
    @NotBlank
    @Username
    private String username;

    @NotBlank
    @Password
    @Builder.Default
    private String password = "123456";
  }
```

# lombok 踩坑

- @Data 有一个坑，占坑
equals 比较的是 HashCode（非静态成员变量都会影响）， == 比较的是引用地址。
更新一个对象后，会出现内存地址不变，HashCode 变化的情况，这时候使用 equals 和 == 就会出现不同结果


### idea 引入 var 下划线报错
val/var 用于**局部变量**的修饰，有了这注解修饰后，变量的类型就会自动通过等号右边的表达式推断出来，这个功能借鉴于许多编程语言的自动类型推断的特性。   

 val - 用于修饰不可变变量，  
 var - 修饰可变变量。  

 当 val 修饰的变量被重新赋值时，编译器就会提示异常：Error: java: 无法为最终变量 X 分配值。  

 var 下划线报错其实是 idea 环境问题（各种清 idea 缓存都失败，删除项目目录下 `.idea` 目录即可）

 ###

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20201209105305.png)
https://github.com/mybatis/mybatis-3/issues/1567
