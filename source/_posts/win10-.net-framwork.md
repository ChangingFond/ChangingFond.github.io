---
title: Windows8/8.1/10安装.NET Framework 3.5
date: 2016-07-19 23:11:24
tags: Windows
categories: 奇技淫巧
---

> 之前在重装win 10系统后安装Microsoft SQL Server 2012，却提示需要.net framework3.5环境，但是Windows8/8.1/10现在都是默认的4.0，用微软自带的在线安装等了半天进度条根本不动。

<!--more-->

## 安装步骤

1. 先挂载Win8&Win8.1&Win10的镜像(安装系统的那个iso镜像文件,可以使用Daemon虚拟光驱挂载,加载之后注意盘符名称，假设为G)

2. 管理员权限运行命令提示符，方法：``command+X``，找到命令提示符(管理员)，或者``command+R``，输入`cmd`，回车，然后将以下代码复制进命令提示符窗口
``` bash
Dism /online /enable-feature /featurename:NetFx3 /All /Source:G:\sources\sxs /LimitAccess
```

 > 注意:将G:替换成你挂载系统所在的盘符
