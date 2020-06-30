# SpringBoot 介绍
Spring Boot就是 **一个内嵌Web服务器（tomcat/jetty）的可执行程序的框架** 。你开发的web应用不需要作为war包部署到web服务器中，而是作为一个可执行程序，启动时把Web服务器配置好，加载起来。

Spring Cloud是一套微服务开发和治理框架，来自Netflex的OSS，包含了微服务运行的功能，比如远程过程调用，动态服务发现，负载均衡，限流等。

SpringBoot 本质上就是一个企业级开发的脚手架，用来代替 Spring，是 JavaEE 开发的一站式解决方案

SpringBoot 的优点：
- 嵌入式的 Servlet 容器，应用无需打成 war 包放到 tomcat 中运行
- starter 启动器进行自动依赖与版本控制（比如开发 web 应用，直接引入 web 启动器，启动器帮我们管理 web 相关的依赖和版本）
- 无需配置 XML，配置轻量（约定大于配置）
- 和微服务、云计算的天然集成（Spring Boot比较适合微服务部署方式，不再是把一堆应用放到一个Web服务器下，重启Web服务器会影响到其他应用，而是每个应用独立使用一个Web服务器，重启动和更新都很容易。）

缺点：
入门容易精通难，因为SpringBoot中有大量的自动配置，如果不了解 Spring 底层的 API，就不能对 Springboot 做更深层的定制。
