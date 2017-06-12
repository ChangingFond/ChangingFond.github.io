---
title: SQL Server导入超大SQL文件的方法
date: 2016-10-28
categories: 编程笔记
tags: [SQL, SQL Server]
---

> 在实验室处理数据时，遇到一张20w记录的表需要恢复，初以为直接在dbms中直接导入sql即可，然而显示内存不够，无法导入。

<!--more-->

## 命令行导入

用微软自带的sqlcmd工具，可以导入执行。以SQL Server 2014版本为例：

1. Win+R 键入：cmd 命令，开启命令行工具；

2. 键入：
``` bash
cd C:\Program Files\Microsoft SQL Server\100\Tools\Binn （具体目录路径跟你安装的SQL位置有关）
```

3. 键入：
``` bash
sqlcmd -S localhost -U username -P 123456 -d dbname -i db.sql
```

参数说明：-S 服务器地址 -U 用户名 -P 密码  -d 数据库名称 -i 脚本文件路径

> 建议将数据脚本文件拷到此目录，就只用写文件名，而不用写全路径了。注意参数大小写和空格符号。
