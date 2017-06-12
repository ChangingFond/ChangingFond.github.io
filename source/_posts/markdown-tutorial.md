---
title: Hello Markdown
categories: 编程笔记
tags: Markdown
date: 2016-8-25 11:52:50
---

![Markdown](/uploads/markdown.jpg)

> We believe that writing is about content, about what you want to say – not about fancy formatting.  
我们坚信写作写的是内容，所思所想，而不是花样格式。  
— Ulysses for Mac

<!--more-->

## Markdown介绍

> Markdown 是一种轻量级标记语言，它允许人们使用易读易写的纯文本格式编写文档，然后转换成格式丰富的HTML页面。    ——*<a href="https://zh.wikipedia.org/wiki/Markdown" > [ 维基百科 ]*

## Markdown官方文档

点击以下链接可以查看官方的Markdown语法规则文档
> * [创始人 John Gruber 的 Markdown 语法说明](http://daringfireball.net/projects/markdown/syntax)
* [Markdown中文版语法说明](http://wowubuntu.com/markdown/)

## Markdown编辑器

| Mac OX | Windows | Web |
| --------------- |:-------------:|--------------------|
| [Mou](http://25.io/mou/) | [Atom](http://atom.io/) |[简书](http://www.jianshu.com/)|
| [Ulysses for Mac]() | [MarkdownPad](http://markdownpad.com/) |[csdn](http://write.blog.csdn.net/mdeditor)|

## Markdown语法

### 标题
```
# 一级标题
## 二级标题
### 三级标题
#### 四级标题
##### 五级标题
###### 六级标题
```
> 在#号后加一个空格，这是最标准的 Markdown语法

### 引用

如果你需要引用一小段别处的句子，就要用引用的格式
```
> 这是一个引用
```
就会出现以下效果
> 这是一个引用

### 链接

```
[点击进入百度](http:\\baidu.com)
```
就会出现以下效果
> [点击进入百度](http:\\baidu.com)

**注意**：引用先定义 [ref_name]:url，然后在需要写入url的地方，这样使用[锚文本][ref_name]，通常的ref_name一般用数字表示，这样显得专业

### 图片

```
![Markdown](\uploads\markdown.jpg)
```
就会出现以下效果
> ![Markdown](\uploads\markdown.jpg)

### 粗体与斜体

```
**这是粗体**
*这是斜体*
```
就会出现以下效果
> ** 这是粗体 **  
*这是斜体*

### 换行

* 单一段落(`<p>`) 用一个空白行
* 连续两个空格 会变成一个`<br>`
* 连续3个`*`符号，然后是空行，表示`<hr>`横线

### 有序列表

有序列表直接在文字前加1. 2. 3. 符号要和文字之间加上一个字符的空格

```
1. 第一行
2. 第二行
3. 第三行
```
就会出现以下效果
> 1. 第一行
2. 第二行
3. 第三行

### 无序列表

只需要在文字前加上 * 即可变为无序列表，符号要和文字之间加上一个字符的空格
```
* 第一行
* 第二行
* 第三行
```
就会出现以下效果
> - 第一行
- 第二行
- 第三行

### 表格

最麻烦最累人的格式
```
| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |
```
就会出现以下效果

| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

### 代码框

作为程序猿，需要在文章里优雅的引用代码框，只需要用三个 \` (反引号)包裹代码块

实例如下：

``` javascript
var canvas = document.getElementById("canvas");
var context = canvas.getContext("2d");
```

### 特殊符号

 - 用`\`来转义，表示文本中的markdown符号
 - 可以在文本中直接使用html标签，但是要注意在使用的时候，前后加上空行

***

至此，已熟悉Markdown入门级语法，想要了解更多功能，请参见官方文档。

***
