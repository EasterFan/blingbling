> mysql 知识点：事务、存储引擎、索引、锁

## 事务的隔离级别：
### 什么是事务？
事务就是对一系列的数据库操作（比如插入多条数据）进行统一的提交或回滚操作，如果插入成功，那么一起成功，如果中间有一条出现异常，那么回滚之前的所有操作。

这样可以防止出现脏数据，防止数据库数据出现问题。
### 事务的特点？  
指的是 ACID，如下图所示：  
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20210310180007.png)

1. 原子性： 事务是最小的执行单位，不允许分割。事务的原子性确保动作要么全部完成，要么完全不起作用；
2. 一致性： 执行事务前后，数据保持一致，例如转账业务中，无论事务是否成功，转账者和收款人的总额应该是不变的；
3. 隔离性： 并发访问数据库时，一个用户的事务不被其他事务所干扰，各并发事务之间数据库是独立的；
4. 持久性： 一个事务被提交之后。它对数据库中数据的改变是持久的，即使数据库发生故障也不应该对其有任何影响。

### 并发事务带来的问题
在典型的应用程序中，多个事务并发运行，经常会操作相同的数据来完成各自的任务（多个用户对统一数据进行操作）。并发虽然是必须的，但可能会导致以下的问题。  

1. 脏读：事务 A 读取了事务 B 更新的数据，然后 B 回滚操作，那么 A 读取到的数据是脏数据。

2. 不可重复读：事务 A 多次读取同一数据，事务 B 在事务 A 多次读取的过程中，对数据作了更新并提交，导致事务 A 多次读取同一数据时，结果不一致。  

3. 幻读：系统管理员 A 将数据库中所有学生的成绩从具体分数改为 ABCDE 等级，但是系统管理员 B 就在这个时候插入了一条具体分数的记录，当系统管理员 A 改结束后发现还有一条记录没有改过来，就好像发生了幻觉一样，这就叫幻读。

小结：不可重复读的和幻读很容易混淆，不可重复读侧重于修改，幻读侧重于新增或删除。解决不可重复读的问题只需锁住满足条件的行，解决幻读需要锁表。

### 事务的隔离级别？
SQL 标准定义了四个隔离级别：

- READ-UNCOMMITTED(读取未提交)： 最低的隔离级别，事务中的修改，即使没有提交，对其他事务也都是可见的，可能会导致脏读、幻读或不可重复读。

- READ-COMMITTED(读取已提交)： 事务从开始直到提交之前，所做的任何修改对其他事务都是不可见的，可以阻止脏读，但是幻读或不可重复读仍有可能发生。

- REPEATABLE-READ(可重复读)： 对同一字段的多次读取结果都是一致的，除非数据是被本身事务自己所修改，可以阻止脏读和不可重复读，但幻读仍有可能发生。

- SERIALIZABLE(可串行化)： 最高的隔离级别，完全服从ACID的隔离级别。所有的事务依次逐个执行，这样事务之间就完全不可能产生干扰，也就是说，该级别可以防止脏读、不可重复读以及幻读。

不同的隔离级别有不同的现象，并有不同的锁定/并发机制，隔离级别越高，数据库的并发性就越差。  

mysql 默认的事务隔离级别是可重复读。


## 数据库索引
### 什么是索引
索引，类似于书籍的目录，想找到一本书的某个特定的主题，需要先找到书的目录，定位对应的页码。

MySQL 中存储引擎使用类似的方式进行查询，先去索引中查找对应的值，然后根据匹配的索引找到对应的数据行。

索引是一种用于快速查询和检索数据的数据结构。常见的索引结构有: B 树， B+树和 Hash。  

#### 索引有什么好处？
1. 提高数据的检索速度，降低数据库IO成本：使用索引的意义就是通过缩小表中需要查询的记录的数目从而加快搜索的速度。
2. 降低数据排序的成本，降低CPU消耗：索引之所以查的快，是因为先将数据排好序，若该字段正好需要排序，则正好降低了排序的成本。

#### 索引有什么坏处？
1. 降低更新表的速度：当对表中的数据进行增删改的时候，如果数据有索引，那么索引也需要动态的修改，会降低 SQL 执行效率。

2. 占用物理存储空间 ：索引需要使用物理文件存储，也会耗费一定空间。

#### 索引的使用场景？
1. 对非常小的表，大部分情况下全表扫描效率更高。
2. 对中大型表，索引非常有效。
3. 特大型的表，建立和使用索引的代价随着增长，可以使用分区技术来解决。

提示：实际场景下，MySQL 分区表很少使用，原因可以看看 《互联网公司为啥不使用 MySQL 分区表？》 文章。
对于特大型的表，更常用的是“分库分表”，目前解决方案有 Sharding Sphere、MyCAT 等等。  


#### 索引的类型？
索引，都是实现在存储引擎层的。主要有六种类型：  

1、普通索引：最基本的索引，没有任何约束。
2、唯一索引：与普通索引类似，但具有唯一性约束。
3、主键索引：特殊的唯一索引，不允许有空值。
4、复合索引：将多个列组合在一起创建索引，可以覆盖多个列。
5、外键索引：只有InnoDB类型的表才可以使用外键索引，保证数据的一致性、完整性和实现级联操作。
6、全文索引：MySQL 自带的全文索引只能用于 InnoDB、MyISAM ，并且只能对英文进行全文检索，一般使用全文索引引擎。  

常用的全文索引引擎的解决方案有 Elasticsearch、Solr 等等。最为常用的是 Elasticsearch。  

我们是明源云天际平台，招正式员工，工作地点在花山软件新城，双休五险按照实际工资缴纳一金是8%，待遇尚可
岗位有 java开发、.net开发、测试、技术专家、技术顾问、高级产品经理
有需要的找我内推呀，简历可发邮箱zhanghm02@mingyuanyun.com
交流可加wx yanfei981213，备注光谷社区内推
具体岗位需求后续补充～～～～


jvm 、类加载过程、线程、常用注解、mysql 存储引擎结构B tree、sql 优化

谈 offer：
- 薪资构成
- 月薪
- 年终奖
- 社保公积金
- 商业保险
- 出差和加班
