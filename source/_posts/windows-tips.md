---
title: Windows常见问题及解决技巧
date: 2018-05-01 17:31:56
updated: 2018-06-20 9:49:12
tags: Windows
categories: 奇技淫巧
---

> 收集整理Windows系统使用过程中遇到的一些问题和解决办法，不定期更新。

<!--more-->

## Windows8/8.1/10安装.NET Framework 3.5

　　之前在重装win 10系统后安装Microsoft SQL Server 2012，却提示需要.net framework3.5环境，但是Windows8/8.1/10现在都是默认的4.0，用微软自带的在线安装等了半天进度条根本不动。

1. 先挂载Win8&Win8.1&Win10的镜像(安装系统的那个iso镜像文件,可以使用Daemon虚拟光驱挂载,加载之后注意盘符名称，假设为G)
2. 管理员权限运行命令提示符，方法：``command+X``，找到命令提示符(管理员)，或者``command+R``，输入`cmd`，回车，然后将以下代码复制进命令提示符窗口
`Dism /online /enable-feature /featurename:NetFx3 /All /Source:G:\sources\sxs /LimitAccess`　　注意:将G:替换成你挂载系统所在的盘符

## 关闭Win 10自动更新

1. 第一种方法适用win10所有版本系统。打开控制面板->管理工具->服务->双击Windows Update，点击停止按钮停止服务，将启动类型改为禁用。打开恢复选项卡，将第一次失败改为无操作
![](http://7xwh8v.com1.z0.glb.clouddn.com/18-5-2/2543953.jpg)
![](http://7xwh8v.com1.z0.glb.clouddn.com/18-5-2/34164800.jpg)

2. 第二种方法适用于除了win10家庭版的其他系统。先按 win键+R 运行`gpedit.msc`，打开计算机配置-->管理模板-->Windows组件-->Windows更新，点击配置自动更新，选择已禁用后保存

## Win 10家庭中文版开启远程桌面

　　Win 10家庭版默认是不支持远程桌面的，下载安装一个自动化工具，解压后以管理员身份运行install.bat即可。[链接地址](https://github.com/binarymaster/rdpwrap/releases)

## 按住Shift键右键点击空白处“在此处打开命令提示符”而不是PowerShell窗口

1. 打开注册表编辑器，定位至：
　`\HKEY_CLASSES_ROOT\Directory\Background\shell\Powershell\command`
2. 更改注册表项所有者权限，在command项上点击右键，选择权限，点击高级按钮打开“command的高级安全设置”窗口，点击“所有者：TrustedInstaller”右侧的“更改”按钮，打开“选择用户或组”窗口。在“输入要选择的对象名称”框中输入当前用户名，然后点击右侧的“检查名称”按钮。如果输入正确，点击“检查名称”之后就会自动把你输入的对象名称显示为标准的用户名称，并添加下划线（如上图）；反之，如果输入的用户名错误，点击“检查名称”之后就会显示提示。（如果不清楚当前登录系统的用户名，你也可以输入“Everyone”，这个不会有错，但是却会修改所有用户的权限，可能存在安全隐患。）点击“确定”关闭“选择用户或组”窗口，回到“command的高级安全设置”窗口，你会发现“所有者”已经变成了你刚才输入的用户。然后点击“确定”关闭“command的高级安全设置”窗口，回到“command的权限”设置窗口。选中“组或用户名”列表中的“Administrators”，在下面的“Administrators的权限”设置框中勾选“完全控制”。点击“确定”关闭“command的权限”设置窗口，回到注册表编辑器。
3. 在右侧窗口双击默认值打开编辑字符串窗口，把数值数据修改为
　`cmd.exe /s /k pushd "%V"`
4. 如果想要取消修改的话，把默认值的数值数据改回如下值即可：
　`powershell.exe -noexit -command Set-Location -literalPath '%V'`

## Win 10家庭中文版打开组策略
　　在桌面新建记事本文件，粘贴下列代码，并将文件格式改为bat。
```bash
   @echo off
   pushd "%~dp0"
   dir /b C:\Windows\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >List.txt
   dir /b C:\Windows\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>List.txt
   for /f %%i in ('findstr /i . List.txt 2^>nul') do dism /online /norestart /add-package:"C:\Windows\servicing\Packages\%%i"
   pause
```
