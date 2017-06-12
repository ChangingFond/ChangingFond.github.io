---
title: Windows下搭建Django开发环境
categories: 编程笔记
tags: python
date: 2016-10-1 9:23:30
---

**Django**是用 Python 语言写的开源 Web 开发框架，它鼓励快速开发，并遵循 MVC 设计和 BSD 版权。Django 根据比利时的爵士音乐家 Django Reinhardt 命名.

<!--more-->

### 安装Python环境
在安装Django框架之前，确保电脑已经安装配置好Python环境
检测Python环境可在命令行直接键入``` python ```,若出现以下代码则Python环境已成功配置
``` bash
Python 3.6.0a3 (v3.6.0a3:f3edf13dc339, Jul 11 2016, 21:40:24) [MSC v.1900 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
```
### 下载Django框架
- [Django官网](http://www.djangoproject.com/download/)下载
- 通过Git拉取
``` bash
	git clone https://github.com/django/django.git
```
> Note: Django源代码文件与Python文件夹放在同一根目录下，如D:\Django，此文件夹下还有D:\Python36。

### 安装Django
``` bash
	cd D:\Django  # Django下载位置
	python setup.py install  # Django被安装到D:\Python\lib\site-packages
```
### 验证Django
打开命令行
``` bash
	python
	import django
	django.get_version()
```
如果出现版本号，即Django已经安装成功
### 创建第一个Django项目
打开命令行，键入
``` bash
	django-admin startproject 项目路径 # 如 E:\cs\DjangoTest
```
> 如果想在任意文件夹下执行上述命令而不输入全路径，需要将```D:\Python\lib\site-packages\django\bin```添加到环境变量

执行上述命令之后，会发现在安装路径下出现以下文件
```
	DjangoTest
	├── manage.py
	└── mysite
    ├── __init__.py
    ├── settings.py
    ├── urls.py
    └── wsgi.py

1 directory, 5 files
```
### 运行Django服务器
进入项目文件夹执行
``` bash
	python manage.py runserver 8000
	> 8000是默认端口号
```
在浏览器打开```127.0.0.1:8000```，如果出现以下内容
``` http
	It worked!
	Congratulations on your first Django-powered page.
	Of course, you haven't actually done any work yet. Next, start your first app by running python manage.py startapp [app_label].
	You're seeing this message because you have DEBUG = True in your Django settings file and you haven't configured any URLs. Get to work!
```
至此，windows下Django环境搭建成功！
