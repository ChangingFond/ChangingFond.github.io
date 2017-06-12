---
title: 小试Ubuntu Server
date: 2016-07-18 11:45:33
tags: Linux
categories: 编程笔记
---

> 今天偶尔逛某里云发现有个云翼计划， 针对大学生可9.9一个月购买一台ECS，虽然本人已经在某讯搭建有ECS，但鉴于其是Windows Server，特想试试Linux Server的一些花样，话不多说，先买为敬。一个月使用时间，足够我折腾一番。

![1](http://7xwh8v.com1.z0.glb.clouddn.com/16-7-18/36478356.jpg)

<!-- more --->

## 配置
- CPU:1核
- 内存:1024MB
- 带宽:1Mbps(峰值)
- 操作系统:Ubuntu 14.04 64位

> 一个字，渣，也是，便宜没好货。

创建实例成功后，在本地远程连接到服务器一探究竟，显示无法联机。
百度后才知道是服务器端没有开启远程连接，无奈之下，只有在阿里控制台先进入服务器

## 远程连接

``` bash
sudo apt-get install xrdp
```

在本地输入cmd + mstsc输入账号密码时终于远程连接服务器。

![2](http://7xwh8v.com1.z0.glb.clouddn.com/16-7-18/20632477.jpg)

命令行实在是不会用，就想安装个图形界面

## KUbuntu安装

开机后输入图形界面的命令 ``startx``，提示安装``xinit``

``` bash
sudo apt-get install xinit
```
安装完后终端由黑色变成了白底黑字，出现X型的鼠标指针

![3](http://7xwh8v.com1.z0.glb.clouddn.com/16-7-18/23562232.jpg)

安装桌面环境。本人安装的是KUbuntu。安装命令如下：

``` bash
sudo apt-get install kubuntu-desktop
```

![4](http://7xwh8v.com1.z0.glb.clouddn.com/16-7-18/5749201.jpg)

重启后我们看到了kubuntu界面了,这下我傻眼了，这个界面跟我之前用到的ubuntu看上去差别太大

![5](http://7xwh8v.com1.z0.glb.clouddn.com/16-7-18/84508635.jpg)


略微体验了一下，
但是kde毕竟太(ka)过(cheng)于(gou)炫，

## 卸载

kde的桌面环境的安装包大概有600-700M，还是比较大的，都差不多赶上了一个ubuntu系统大小的一半了，为了节省空间更是决定卸载掉。

``` bash
sudo apt-get --purge remove libqt3-mt libqtcore4
```

关于开机画面的解决方案

``` bash
sudo apt-get autoremove plymouth-theme-kubuntu-logo
```

重启之后，回归黑框框，听说黑框框很装逼，但门道多着呢，继续探索！

***

## 附录1:Linux下关机重启命令

### 重启命令：

```
1. reboot
2. shutdown -r now 立刻重启(root用户使用)
3. shutdown -r 10 过10分钟自动重启(root用户使用)
4. shutdown -r 20:35 在时间为20:35时候重启(root用户使用)
```

> 如果是通过`shutdown`命令设置重启的话，可以用`shutdown -c`命令取消重启

### 关机命令：
```
1. halt   立刻关机
2. poweroff 立刻关机
3. shutdown -h now 立刻关机(root用户使用)
4. shutdown -h 10 10分钟后自动关机
```

> 如果是通过`shutdown`命令设置关机的话，可以用`shutdown -c`命令取消重启

## 附录2:Linux下各大桌面环境/窗口管理器对比

|桌面环境/窗口管理器	 |RAM used	| CPU used	| 类型|
| ------------- |:-------------:| :-----:| :------:|
|KDE 4.6	| 363 MB|	 4 %	| 桌面环境|
|Unity	| 271 MB|	 14%	| 桌面环境(shell)|
|GNOME 3|	 193 MB	| 10%	|  桌面环境|
|GNOME 2.x	 |191 MB	| 1 %|	 桌面环境|
|XFCE 4.8	| 144 MB|	 10 %	  |桌面环境|
|LXDE	| 85 MB|	 10 %	  |桌面环境|
|IceWM	| 85 MB|	 2 %|	  窗口管理器|
|Enlightenment (E17 Standard)	| 72 MB|	 1 %|	 窗口管理器|
|Fluxbox	| 69 MB|	 1 %|	 窗口管理器|
|OpenBox|	 60 MB	| 1 %	 |窗口管理器|
|JWM	 |58 MB	 |1 %	| 窗口管理器|

***
