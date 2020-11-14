# Ansible + jenkins + GitLab 持续交付工具之 Ansible

## Ansible 是什么
一款持续交付工具。

持续交付 = 版本控制 （GitLab、Github）+ 持续集成工具（Jenkins） + 部署工具（Ansible、Saltstack、Chef）

版本控制用来协作开发代码，jenkins 把代码拉到本地进行集成，部署工具将集成后的代码从本地推送到云端服务器。

## Ansible 为什么
发展背景？
传统运维 - 运维人员到甲方公司，通过敲命令行部署环境现场交付

产出一份运维部署方案。

Ansible VS Chef VS Saltstack
Ansible 更符合敏捷概念

## Ansible 怎么做
> centos7 + python3.6 + virtualenv + Ansible2.5

将 Ansible 所处的 python 环境和生产环境隔离开, 而不是使用 yum 包安装，推荐使用 Git 安装 Ansible，保证 Ansible 在一个隔离的 python 环境下运行。

安装步骤：
- 1. centos7 主机 + python3.6 环境
- 2. 安装 virtualenv - 用于隔离 python 与 Ansible
- 3. 在 centos7 主机下创建 Ansible 账户并安装 python3.6 版本 virtualenv 实例
- 4. Git 源码安装 ansible2.5
- 5. 加载 python3.6 virtualenv 环境
- 6. 安装 ansible 依赖包
- 7. 在 python3.6 虚拟环境下加载 ansible2.5
- 8. 验证 ansible 2.5

```bash
# 安装 virtualenv
pip install virtualenv

```
