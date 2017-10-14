---
title: CentOS 7安装MongoDB数据库
date: 2017-10-14 21:42:35
categories:
- 技术人生
tags:
- Linux

---

在CentOS 7服务器上安装MongoDB数据库，并设置开机启动。

<!-- more -->

## 下载安装包

1. 打开MongoDB官网[下载地址](https://www.mongodb.com/download-center#community)
2. 选择对应的版本和系统环境，获取下载链接，如CentOS 7的下载链接为`https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-3.4.9.tgz`
3. 运行
```
  wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-3.4.9.tgz
  tar zxvf mongodb-linux-x86_64-rhel70-3.4.9.tgz   # 解压
  mv mongodb-linux-x86_64-rhel70-3.4.9 /usr/local/mongodb  # 移动
```

## 创建数据文件路径

## 创建配置文件

## 启动测试

## 设置开机自动启动

## 添加管理员与用户认证
