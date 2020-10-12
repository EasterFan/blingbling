# Flyway 使用


## Maven 多模块使用 Flyway 管理版本控制

## 一个比较坑的点
idea 新建目录变成 db.migration,但是在包下可以这样的新建

## 关于用 dependency 还是 plugin 的选择
用了 plugin 就不能正常迁移了~~

```xml
    </dependencie>
        <dependency>
            <groupId>org.flywaydb</groupId>
            <artifactId>flyway-core</artifactId>
        </dependency>
    </dependencies>

<!--    <build>-->
<!--        <plugins>-->
<!--            <plugin>-->
<!--                <groupId>org.flywaydb</groupId>-->
<!--                <artifactId>flyway-maven-plugin</artifactId>-->
<!--                <version>7.0.2</version>-->
<!--                <configuration>-->
<!--                </configuration>-->
<!--            </plugin>-->
<!--        </plugins>-->
<!--    </build>-->
```
## 参考
- https://github.com/smyachenkov/multimodule-flyway-demo
- https://stackoverflow.com/questions/55772574/flyway-cannot-find-migrations-location-in-classpathdb-migration
