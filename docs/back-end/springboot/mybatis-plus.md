# Mybatis - plus

Mybatis VS JPA

Mybatis 优势：
- sql 语句可以自由控制，更灵活，性能更高（略高一点）
- SQL 与代码分离，易于阅读和维护
- 提供 xml 标签，支持编写动态 SQL 语句

 JPA 优势：
 - 移植性更好，只需编写 JPQL 语句，findby，数据库发生切换也没关系
 - 提供了很多 CRUD 方法，开发效率高
 - 对象化程度高

 Mybatis 劣势：
 - 简单的CRUD操作还得写 SQL
 - XML 中有大量的 SQL 要维护，越到开发后期业务越复杂，越难维护
 - Mybatis 自身功能很有限，分页都不支持，但是支持各种插件


 Mybatis-plus 的工作原理：
![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200926105437.png)

 Mybatis-plus 的特性：
 - 无侵入（只增强不改变），损耗小（容器启动时注入），强大的 CRUD 操作
