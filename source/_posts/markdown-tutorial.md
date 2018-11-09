---
title: Hello Markdown
categories: 编程笔记
tags: Markdown
date: 2016-8-25 11:52:50
photos:
- http://changingfond.oss-cn-hangzhou.aliyuncs.com/16-8-25/60310193.jpg
---

> We believe that writing is about content, about what you want to say – not about fancy formatting.  
我们坚信写作写的是内容，所思所想，而不是花样格式。  
— Ulysses for Mac

<!--more-->

# Markdown介绍

Markdown 是一种轻量级标记语言，它允许人们使用易读易写的纯文本格式编写文档，然后转换成格式丰富的HTML页面。    ——*<a href="https://zh.wikipedia.org/wiki/Markdown" > [ 维基百科 ]*

# Markdown参考文档

点击以下链接可以查看Markdown语法规则文档
* [创始人 John Gruber 的 Markdown 语法说明](http://daringfireball.net/projects/markdown/syntax)
* [Markdown中文版语法说明](http://wowubuntu.com/markdown/)
* [Markdown，你只需要掌握这几个](https://www.zybuluo.com/AntLog/note/63228)

# Markdown编辑器

| Mac OX | Windows | Web |
| --------------- |:-------------:|--------------------|
| [Mou](http://25.io/mou/) | [Atom](http://atom.io/) |[简书](http://www.jianshu.com/)|
| [Ulysses for Mac]() | [MarkdownPad](http://markdownpad.com/) |[csdn](http://write.blog.csdn.net/mdeditor)|

# Markdown语法

## 标题
```
# 一级标题
## 二级标题
### 三级标题
#### 四级标题
##### 五级标题
###### 六级标题
```
> 在#号后加一个空格，这是最标准的Markdown语法

## 引用

如果你需要引用一小段别处的句子，就要用引用的格式
```
> 这是一个引用
```
就会出现以下效果
> 这是一个引用

使用`>`表示引用，`>>`表示引用里面再套一层引用，依次类推。

## 链接

```
[点击进入博客](http://blog.fangchengjin.cn/)
[点击进入博客(鼠标悬浮带title)](http://blog.fangchengjin.cn/ "ChangingFond")
```
就会出现以下效果
> [点击进入博客](http://blog.fangchengjin.cn/)
> [点击进入博客(鼠标悬浮带title)](http://blog.fangchengjin.cn/ "ChangingFond")

**注意**：引用先定义 [ref_name]:url，然后在需要写入url的地方，这样使用[锚文本][ref_name]，通常的ref_name一般用数字表示，这样显得专业

## 图片

```
![Markdown](http://changingfond.oss-cn-hangzhou.aliyuncs.com/16-7-18/36478356.jpg "Optional title")
```
就会出现以下效果
![Markdown](http://changingfond.oss-cn-hangzhou.aliyuncs.com/16-7-18/36478356.jpg "Optional title")

## 粗体与斜体

```
**这是粗体**
__这是粗体__
*这是斜体*
_这是斜体_
```
就会出现以下效果
> **这是粗体**
> __这是粗体__
> *这是斜体*
> _这是斜体_

**注意**：前后的 * 或 _ 与要加粗或倾斜的字体之间不能有空格。

## 有序列表

有序列表直接在文字前加1. 2. 3. 符号要和文字之间加上一个字符的空格
```
1. 第一行
2. 第二行
3. 第三行
```
就会出现以下效果
> 1. 第一行
> 2. 第二行
> 3. 第三行

## 无序列表

只需要在文字前加上 * (星号) 或者 + (加号) 或者 - (减号) 即可变为无序列表，符号要和文字之间加上一个字符的空格
```
* 第一行
* 第二行
* 第三行
```
就会出现以下效果
> - 第一行
> - 第二行
> - 第三行

## 表格

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

## 代码框

在文章里引用代码框，只需要用三个反引号包裹代码块
\`\`\`
var canvas = document.getElementById("canvas");
var context = canvas.getContext("2d");
\`\`\`
就会出现以下效果
```
  var canvas = document.getElementById("canvas");
  var context = canvas.getContext("2d");
```

## 分割线

你可以在一行中用三个以上的星号、减号、底线来建立一个分隔线，行内不能有其他东西。
你也可以在星号或是减号中间插入空格。下面每种写法都可以建立分隔线：
```
  * * *
  ***
  *****
  - - -
  ---------------------------------------
```

## 特殊字符

- 可以在文本中直接使用html标签，但是要注意在使用的时候，前后加上空行
- 依赖 Markdown 来换行，在换行处先按入两个以上的空格然后回车
- 单一段落(`<p>`) 用一个空白行分割
- 用`\`来转义，表示文本中的 Markdown 符号  
  Markdown 支持以下这些符号前面加上反斜杠来帮助插入普通的符号：
  ```
    \   反斜线
    `   反引号
    *   星号
    _   底线
    {}  花括号
    []  方括号
    ()  括弧
    #   井号
    +   加号
    -   减号
    .   英文句号
    !   感叹号
  ```
