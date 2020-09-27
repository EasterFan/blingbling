# Mybatis - plus

## Mybatis VS JPA

### Mybatis 优势：
- sql 语句可以自由控制，更灵活，性能更高（略高一点）
- SQL 与代码分离，易于阅读和维护
- 提供 xml 标签，支持编写动态 SQL 语句

### JPA 优势：
 - 移植性更好，只需编写 JPQL 语句，findby，数据库发生切换也没关系
 - 提供了很多 CRUD 方法，开发效率高
 - 对象化程度高

### Mybatis 劣势：
 - 简单的CRUD操作还得写 SQL
 - XML 中有大量的 SQL 要维护，越到开发后期业务越复杂，越难维护
 - Mybatis 自身功能很有限，分页都不支持，但是支持各种插件


### Mybatis-plus 的工作原理：
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200926105437.png)

 Mybatis-plus 的特性：
 - 无侵入（只增强不改变），损耗小（容器启动时注入），强大的 CRUD 操作
 - 支持 Lambda 形式调用，支持多种数据库
 - 支持多种主键自动生成策略(默认采用雪花算法)，支持 ActiveRecoverd 模式
 - 支持自定义全局通用操作（全局通用方法注入）、支持数据库关键词自动转义
 - 内置代码生成器、内置分页插件、内置性能分析插件（输出 SQL 语句和对应的执行时间）
 - 内置全局拦截插件（可自定义）、内置 SQL 注入剥离器（有效防止 SQL 注入攻击）

## Mybatis 常用操作

### 常用注解
@TableName - 数据表带前缀，但是生成的实体类不想带前缀 - 适用实体类和数据表不对应 的情况
@TableId - 数据表id 不为id，为 user_id 这种的时候，mybatis 不能自动找到，需显示指定
@TableField - 用于实体字段名和表字段名不一致，需一一映射的情况
@TableField(exist = false) - 排除 PO 中非表字段，该字段不插入到数据库中
### 插入操作

### 查询
#### 基本查询
selectById
selectBybatchId
selectByMap

#### 条件构造器查询 - 单表查询
> 以条件构造器为参数查询

排除某些字段不查询：



### 删除

### 更新
