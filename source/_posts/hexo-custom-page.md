---
title: Hexo博客跳过渲染，创建自定义网页
date: 2018-8-7 12:59:50
categories:
- 技术人生
tags:
- hexo
---

Hexo 博客中所见文章都是经由渲染的静态网页，而静态网页的样式都直接由 Hexo 的主题控制，所以 Hexo 博客大部分都呈现出一种高度的统一化与规范化。不过 Hexo 提供了跳过渲染功能，使得我们可以直接在博客中放入自定义网页。比如在博客中放入图片、自定义 404.html 、自定义 About 页面等。

<!-- more -->

## 自定义网页

网页可以是自己编写的，也可以是别人现成的源码。
网页编写完成后，在 Hexo\source 目录下创建一个文件夹，文件夹名称任意，将 Html 文件放置于此文件夹，并重命名为 index.html 。

## 方法一

在html文件中添加跳过渲染指令：

用编辑器打开 Hexo\source 创建的文件夹中的 index.html 文件，在开头添加如下代码即可

```
    ---
    layout: false
    ---
```

添加该指令后，执行 hexo g 命令时便会跳过该 index.html 文件，使得 index.html 不受当前 hexo 主题影响，完全是一个独立的网页。

如果网页引用了 css 或 js ，这些 css 和 js 必须使用外链。

如果引用图片，可以在网页目录下建立 img 文件夹，可以直接引用图片，不必再去创建外链。

## 方法二

使用编辑器打开 Hexo 目录下的_config.yml 文件，找到 skip_render

skip_render 一般有以下四种常用参数：

1. 跳过source目录下的 test.html: skip_render: test.html

2. 跳过source目录下 test 文件夹内所有文件：skip_render: test/*

3. 跳过source目录下 test 文件夹内所有文件包括子文件夹以及子文件夹内的文件：skip_render: test/**

4. 跳过多个路径：
```
skip_render:
 - test.html
 - test/*
```

对格式要求严格，注意填写参数时的格式，添加完成后便不会渲染指定文件/文件夹。

如果网页引用了 css 或 js ，并将整个网页目录设置为跳过渲染，则不必再为 css 和 js 创建外链，可以直接引用。
