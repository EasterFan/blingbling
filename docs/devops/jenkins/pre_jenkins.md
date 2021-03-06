# 开始之前
> CI/CD DevOps DevOps 工具链，


jenkins 学习路径比较简单，图形化界面 + 常用脚本，不抽象，很容易上手。

几个概念：

持续集成(Continuous Integration，CI):代码合并、构建、部署、测试都在一起，不断地执行这个过程，并对结果反馈。

持续部署(Continuous Deployment，CD):部署到测试、生产环境。

持续交付(Continuous Delivery，CD):部署到生产环境，给用户使用。

DevOps：不是某一两个工具，而是一整套方法论，偏重流程化，减少开发、运维、测试之间的沟通障碍

谷歌 5 个 devOps 原则：
- 精简组织架构；
- 愿意承担一部分试错带来的损失；
- 分阶段地一小步一小步地进行转型；
- **最大化地利用工具和自动化流程；**
- **对所有的过程和结果进行记录和分析。**

# 为什么？

传统开发流程：
dev 本地打包 -> 发给 Ops -> Ops 上线 -> 通知测试人员开始测试 -> 测出问题发邮件给 dev

缺点：
- 每个环节都需要人在不断协调，手动部署，增加沟通成本
- 只要有人工干预，在任何一个环节都可能会出现问题，操作失误，部署失败
- 敏捷团队里效率非常高，人工降低团队速度

![](https://cdn.jsdelivr.net/gh/easterfan/picgo/blingbling/2020/20200729111710.png)
