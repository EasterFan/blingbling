> 问题也是现实生活中的一个具体的事物, 也可以通过java 类的形式描述, 并封装成对象.

<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [异常的分类 - Error 和 Exception](#异常的分类---error-和-exception)
- [异常处理的分类 - 抛出和捕获](#异常处理的分类---抛出和捕获)
    - [1. 抛出异常](#1-抛出异常)
    - [2. 捕获异常](#2-捕获异常)
    - [3. 几点说明](#3-几点说明)
- [异常处理之 try-catch-finally](#异常处理之-try-catch-finally)
- [异常处理之 Throws 声明异常类](#异常处理之-throws-声明异常类)
- [异常处理之 throw 抛出异常对象](#异常处理之-throw-抛出异常对象)
- [throws 和 throw 的区别](#throws-和-throw-的区别)
- [自定义异常](#自定义异常)
    - [1. 自定义异常的特点](#1-自定义异常的特点)
    - [2. 自定义异常类的写法](#2-自定义异常类的写法)
  - [RuntimeException 运行时异常](#runtimeexception-运行时异常)
- [异常链 - 异常与继承](#异常链---异常与继承)
  - [1. 异常与继承关系](#1-异常与继承关系)
    - [1.1 父类一个异常](#11-父类一个异常)
    - [1.2 父类多异常](#12-父类多异常)
    - [1.3 父类多异常](#13-父类多异常)
  - [2. 异常链 - 获取前面的异常](#2-异常链---获取前面的异常)
<!-- TOC END -->




异常本质上是程序的**错误**。包括编译期间和运行期间的错误。少写了分号，这些编译器能识别出来的错误是编译错误，编译器不报错但运行出错的错误是运行错误。  

Java异常处理机制，可以更好的提升程序的健壮性。  

如果我们对异常置之不理,程序可能会不正常运行、强制中断运行、造成用户数据丢失、资源无法正常释放、直接导致系统崩溃,显然这不是我们希望看到的结果。  

# 异常的分类 - Error 和 Exception
在Java中,通过Throwable及其子类描述各种不同的异常类型。  
Throwable有两个重要的子类:Exception 和 Error  
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/throwable.png)  
Error是程序无法处理的错误，大多和程序员的操作无关，而是代码运行时JVM出现的问题，比如当JVM内存不足以支撑程序运行时，将出现OutOfMemoryError，这些错误都是不可查的，更多是程序与JVM硬件的冲突，我们是无能为力的，因此，这类异常我们是不需要关心的。  

exception是程序本身可以处理的异常，异常处理就是针对exception异常。  
exception异常分为unchecked exception(运行时异常) 和 checked exception(编译时异常)。  
前者是**编译器不要求强制处置的异常**，Java编译器不会检查这些异常,在程序中可以选择捕获处理,也可以不处理,照样正常编译通过（相对宽松） -- RuntimeException。  

后者是**编译器要求必须处置的异常**，Java编译器会检查这些异常,当程序中可能出现这类异常时,要求必须进行异常处理,否则编译不会通过（相对严格）。  

unchecked exception：RuntimeException类及其子类异常，如NullPointerException(空指针异常)/IndexOutOfBoundsException(下标越界异常)等。  

checked exception：RuntimeException及其子类以外,其他的Exception类的子类。如IOException、SQLException等  

一些常见的异常类：  
![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/commonException.png)  

# 异常处理的分类 - 抛出和捕获
在Java应用程序中,异常处理机制为:**抛出异常**、**捕捉异常**  
java中通过5个关键字处理异常（try catch finally throw throws）    

![](https://raw.githubusercontent.com/EasterFan/PicGo/master/blingbling/2020/SortException.png)  

### 1. 抛出异常
1. 当一个方法出现错误引发异常时,方法创建异常对象并交付运行时系统。
2. 异常对象中包含了异常类型和异常出现时的程序状态等异常信息。
3. 运行时系统负责寻找处置异常的代码并执行

### 2. 捕获异常
1. 在方法抛出异常之后,运行时系统将转为寻找合适的异常处理器。
2. 运行时系统从发生异常的方法开始,依次回查调用栈中的方法,当异常处理器所能处理的异常类型与方法抛出的异常类型相符时,即为合适的异常处理器。
3. 当运行时系统遍历调用栈而未找到合适的异常处理器,则运行时系统终止。同时,意味着Java程序的终止。

### 3. 几点说明
1. 异常总是先被抛出,后被捕捉的
2. Java规定:对于可查异常必须捕捉、或者声明抛出。允许忽略不可查的RuntimeException和Error。
3. 异常的意义:  
对问题进行封装, 将正常的逻辑代码和问题处理的代码分离开,方便阅读.  
4. 异常处理的原则:  
  - 处理方式有两种, try 或者 throws  
  - catch内,要定义针对性的处理方式, 不要简单的定义printStackTrace, 也不要不写.\
  - 当捕获的异常无法处理时,可以在 catch 中继续抛出
  - 捕获异常后, 如果无法处理,可以将捕获的异常转为相关的异常抛出  
```java

// 无法处理,继续抛出

try{

	throw new AException();
} catch (AExcepption e){
	throw e;
}

// 无法处理,转换后抛出
try{
	throw new AException();
} catch (AExcepption e){
	// 先做一些能处理的部分
	throw new BException();
}
```


# 异常处理之 try-catch-finally
![](../assets/trycatch.png)  

try：捕获异常  
catch：对异常进行处理  
finally：无论是否发生异常，finally中的代码总能执行。多为释放占用的资源，关闭文件流，数据库连接等。  
try块后可接零个或多个catch块，如果没有catch块，则必须跟一个finally块。--try必须和catch或finally组合使用  

#### 1. try-catch案例：  

```java
try {
            int one=3,two=0;
            System.out.println(one/two);
        }catch (Exception e){
            // 打印错误的堆栈信息，建议不只是打印堆栈中的异常位置，可以处理异常
            e.printStackTrace();
        }finally {
            System.out.println("=====运算结束=====");
        }
```

#### 2. 多重try-catch案例：  

```java
    public static void test(){
        try {   
	    int one=3,two=0;
            System.out.println(one/two);
        } catch (ArithmeticException e) {
            // 打印错误的堆栈信息
            e.printStackTrace();
            System.out.println("除数不能为0");
        } catch (InputMismatchException e) {
            // 打印错误的堆栈信息
            e.printStackTrace();
            System.out.println("必须输入数字");
        } catch (Exception e){
            // 用父类来兜底其他意料之外的异常
            e.printStackTrace();
            System.out.println("其他错误");
        }finally {
            System.out.println("=====运算结束=====");
        }
    }

```
[两数相除](https://github.com/EasterFan/JavaExercise/blob/master/ExceptionProj/src/_01_trycatch1.java)
#### 3. return和System.exit(1)的区别

return和System.exit()都表示退出程序。  
前者退出后将数据带回到方法被调用处，后者不行。  
前者不会终止finally中的语句，后者会强制终结finally中的语句。  
System.exit(0)表示正常退出，System.exit(1)表示非正常退出，异常中的退出都是System.exit(1).  
另外，finally中的return会屏蔽catch中的return，故不建议在finally中写return。  




#  异常处理之 Throws 声明异常类
> thorws用在函数上,后面跟**异常类名** -- 用于告诉调用者,该函数存在异常  
throw用在函数内,后面跟异常对象。 -- 用于抛出异常对象;

#### 1. throws 特点
- 如果一个方法中可能出现可查异常,要么用try-catch语句捕获,要么用throws声明 **异常类型** 将它抛出（谁调用了这个方法，谁就会接收这个异常并处理）,否则会导致编译错误  

- 使用场景：如果一个方法可能会出现异常,但没有能力处理这种异常,可以在方法声明处用throws子句来声明抛出异常。  

- throws意义：throws适用于分模块开发，由不同的开发人员分别进行方法定义和方法处理。  

比如：汽车在运行时可能会出现故障,汽车本身没办法处理这个故障，那就让开车的人来处理。  

#### 2. throws使用：  
> throws 声明的尽量是具体的异常, 而不是父类总异常 Exception

```java
public static void main(String args[]) {
        // 此处result调用了这个方法，由result处理方法抛出的异常
        try {
            int result = test();
            System.out.println(result);
        } catch (ArithmeticException e) {
            e.printStackTrace();
            System.out.println("=====除数不能为0=====");
        } catch (InputMismatchException e) {
            e.printStackTrace();
            System.out.println("=====不能输入字母=====");
        }
    }

    private static int test() throws ArithmeticException,InputMismatchException{
        Scanner input = new Scanner(System.in);       
        int one = input.nextInt();      
        int two = input.nextInt();
        return one/two;
        }
```
[Throws声明异常类型，调用者处理--两数相除](https://github.com/EasterFan/JavaExercise/blob/master/ExceptionProj/src/_02_Throws.java)  

#### 3. throws的继承  
当子类重写父类抛出异常的方法时,声明的异常必须是父类方法所声明异常的同类或子类。  

# 异常处理之 throw 抛出异常对象
> throw new IOException();

#### 1. throw 的特点  
1. 抛出异常的意义（我们为什么要主动用throw抛出一个异常对象？）  
  - 规避可能出现的风险  
  - 完成一些程序逻辑（比如未成年人进入网吧，抛出异常）  

2. throw 抛出的只能够是可抛出父类Throwable 或者其子类的实例对象，不能抛出其他类的实例对象。  
```java
throw new String(“出错啦”); //是错误的  
```

3. throw 抛出的尽量为**Excption/IOException/SQLException**等 checkedException 类型的异常，而不是uncheckedException类型，因为编译器对后者的约束较为宽松，写出来不报错，前者写出来会报错。

#### 2. throw 抛出异常后的处理方法
> 两种方法: try catch 自己处理  
	    throws 抛出让调用者处理


自己处理:  

```java
public static void main(String args[]){
        testAge();
    }
    public static void testAge(){
            try {
                System.out.println("请输入年龄");
                Scanner input = new Scanner(System.in);
                int age = input.nextInt();

                if(age < 18){
                    throw new Exception("未成年人不能进入网吧");
                }else {
                    System.out.println("可以进入网吧");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
```
[Throw抛出异常对象自己抛出，自己处理--网吧年龄限制](https://github.com/EasterFan/JavaExercise/blob/master/ExceptionProj/src/_03_Throw1.java)  

throws声明，让调用的方法处理:  

```java
public static void main(String args[]){
        try {
            testAge();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void testAge() throws Exception{
        System.out.println("请输入年龄");
        Scanner input = new Scanner(System.in);
        int age = input.nextInt();
        if(age < 18){
            throw new Exception("未成年人不能进入网吧");
        }else {
            System.out.println("可以进入网吧");
        }
    }
```
[Throw抛出异常对象自己抛出，Throws声明，调用者处理--网吧年龄限制](https://github.com/EasterFan/JavaExercise/blob/master/ExceptionProj/src/_04_Throw2.java)  

# throws 和 throw 的区别
throws在函数名后, 可声明多个**异常类**,抛出的是异常类  
throw 在函数中, 抛出的是**异常对象**.

# 自定义异常
> 因为项目中会出现特有的问题(该类问题并没有被 java 描述并封装成对象)，可以通过**自定义异常**描述特定业务产生的异常类型  

### 1. 自定义异常的特点
1. 所谓自定义异常,就是定义一个类,去**继承Throwable类**或者它的子类(Exception)。  
推荐继承 Exception 类, 因为 Exception 是 Throwable 的子类, 拥有更丰富的方法, 如果想要新建一个继承体系,则继承 Throwable.  
2. 自定义的异常类, java 并不认识, 需要手动**建立对象**并抛出(throw).  
3. 当函数内部已经用**throw**抛出异常对象,那就必须要给出对应的处理动作(两种处理方式)  
  - 在函数名处 throws 声明异常
  - 自己 try  catch 处理
4. 父类 Throwable 中已经把异常信息的操作都完成了,子类只需要在构造函数中, 使用`super(String msg)`传入异常信息即可.然后用`getMessage()`获得该参数.  
5. 为什么自定义类要继承异常类?  
因为(Throwable)异常体系具备一个特点:  **异常类** 和 **异常对象** 都可以被抛出, 使程序发生跳转 ,继承后,程序就有了跳转功能.  
且只有这个体系中的类和对象才可以被 throw 和 throws 操作.  

### 2. 自定义异常类的写法
```java
// 一个自定义异常类的写法
class FuShuException extends Exception{
    private int value;
   // 默认构造函数
    FuShuException(){
        super();
    }

    // 接收子类异常信息
    FuShuException(String msg,int value){
        super(msg);
        this.value = value;
    }
    // 获取输入的负数
    public int getValue() {
        return value;
    }
}
```
[自定义异常类 -- 被除数不为负数](https://github.com/EasterFan/JavaExercise/blob/master/ExceptionProj/src/_05_CustomThrowFushu.java)   
[自定义异常类--网吧年龄限制](https://github.com/EasterFan/JavaExercise/blob/master/ExceptionProj/src/_05_CustomThrow.java)  

## RuntimeException 运行时异常
> 运行时异常,也许是因为这个异常,是用户错误输入(空指针, 数组下标越界, 算术异常, 类型转换)造成的,调用者不方便处理,直接挂掉,让用户重新输入

#### 运行时异常特点
1. 在函数内手动抛出运行时异常时,不需要在函数名处用`throws`声明.编译通过  
2. 如果在函数上声明了该异常, 调用者可以不用处理,编译一样通过.  
3. 之所以这样设计, 不在函数名处声明, 是为了不让调用者处理异常, 程序运行时,直接挂掉,然后让程序员修正代码
4. 自定义异常时, 如果该异常的发生, 是用户错误输入造成的,调用者也不方便处理, 就让自定义异常继承 **RuntmeException**
5. 普通异常发生后, 通过 throws 或 trycatch 处理异常,可以让程序继续运行  
RuntimeExcetion 的异常发生后, 不要声明 throws, 也不要用 trycatch 处理, 目的就是为了让程序,在这个异常发生后, 马上停止.  
如果调用者用 trycatch 处理了 RuntimeException 异常, 程序就可以跳过这个异常,继续往下运行.  
但是,我们使用RuntimeException的目的就在于:  让程序就停在这里, 不要往下运行了(因为这个关键异常已经出现, 再往下已经没有计算的必要了)

[RuntimeException - 直接让程序挂掉的使用](https://github.com/EasterFan/JavaExercise/blob/master/ExceptionProj/src/_10_RunTimeExceptionTest.java)  

#  异常链 - 异常与继承

## 1. 异常与继承关系
> 异常在子父类覆盖中的体现

### 1.1 父类一个异常
> 1. 子类方法抛出的异常范围 <= 父类方法抛出的异常范围  
> 2. 继承关系中, 子类重写父类方法,抛出的异常,只能是**父类异常**或者**父类异常的子异常**.  
> 3. 即: 子类重写父类的方法, 子类的异常只能是父类中已经定义的异常, 或者父类的子异常, 子类不能抛出新异常.  


如果子类非要抛出一个新异常, 只能在子类内部 trycatch, 自行解决异常, 不能用 `throws`抛出  

[异常与继承--子类异常<=父类异常](https://github.com/EasterFan/JavaExercise/blob/master/ExceptionProj/src/_09_ExtendsInExceptionTest.java)  

### 1.2 父类多异常
> 如果父类方法抛出多个异常, 那么子类在覆盖方法时,只能抛出父类异常的子集.  

若父类throws了5个异常: A B C D E   
则子类只能 throws 5 个以下的异常

### 1.3 父类多异常
>  若父类方法无异常抛出, 则子类重写的方法,不能抛出任何异常,若子类必须要抛出异常,只能在子类方法内部自行 trycatch 解决.绝对不能throws抛出.  

## 2. 异常链 - 获取前面的异常
在异常链中，最后的异常会覆盖前面的异常，怎样获取前面被覆盖的异常呢？  

[异常链](https://github.com/EasterFan/JavaExercise/blob/master/ExceptionProj/src/_06_ThroableLine.java)  
先在前几个异常中封装e  
```java
throw new Exception("我是test2中抛出的异常",e);
```

最后抛出的时候新建一个异常对象e1，初始化前几个异常
```java
// 封装前两个异常
            Exception e1 = new Exception("我是test3中抛出的异常");
            e1.initCause(e);
            throw e1;
```
[异常链 - 异常中的子类](https://github.com/EasterFan/JavaExercise/blob/master/ExceptionProj/src/_07_ThrowsInherianceSon.java)  

[异常案例 -- 老师讲课异常!](https://github.com/EasterFan/JavaExercise/blob/master/ExceptionProj/src/_08_TeacherExceptionTest.java)  
