---
title: JavaScript学习笔记
date: 2017-9-19 19:51:35
updated: 2017-9-19 19:51:35
categories:
- 编程笔记
tags:
- Frontend
- JavaScript
---

JavaScript学习过程中的一些笔记，不定期更新。

<!-- more -->

## JavaScript与Html
- JavaScript=ECMAScript + DOM + BOM  
- HTML页面中`<script>`标签type属性默认为text/javascript。
- 在使用`<script>`标签嵌入html页面时，只需指定type属性即可。嵌入的js代码中不要包含`</script>`字符串，浏览器会认为其是结束标签。
- html包含外部js文件时，必需指定src属性，必需有闭合标签`</script>`，两个标签之中不能含有js代码（不会被执行）。
- 现代Web应用程序一般把js引用全部放在body元素中内容的后面，使附录中的步骤2,3滞后。
- defer属性会使js**外部脚本**延迟到整个html页面加载完毕后再执行。
- async属性会使js**外部脚本**会在页面load事件之前执行，但可能会在DOMContentLoaded事件之前或之后执行。
- 所有`<script>`元素都会按照在页面中出现的顺序依次解析（不包含defer、async属性）。

> 附: DOM文档加载的步骤：
参考[事件DOMContentLoaded和load的区别](http://www.cnblogs.com/caizhenbo/p/6679478.html)
  1. 解析HTML结构。
  2. 加载外部脚本和样式表文件。
  3. 解析并执行脚本代码。
  4. DOM树构建完成。//DOMContentLoaded
  5. 加载图片等外部文件。
  6. 页面加载完毕。//load

- 文档开始处没有文档类型声明，则浏览器默认开启混杂模式（包含非标准类型）。HTML5页面的标准模式文档类型声明为`<!DOCTYPE html>`。
- <noscript>元素中的内容在浏览器不支持脚本或者脚本被禁用时显示。
- js启用严格模式`"use strict"`(脚本文件的顶部或函数体内容的开头声明)，严格模式的不同如下：
```
  1.八进制Number变量无效
```

## 语法
- 标识符第一个字符可以为`$`，采用驼峰大小写格式，第一个字母小写，剩下的每个有意义的单词的首字母大写。
- 建议使用分号结尾，建议使用`{}`组织代码块（即使代码块只有一行）。
- js变量为松散类型（可以用来保存任何类型-弱类型语言），不建议修改变量所保存值的类型，但是修改有效。
- 使用var定义的变量成为定义该变量的作用域中的局部变量，不使用var定义则为全局变量（不推荐）。
- 一条语句定义多个变量
```javascript
  var message = "hi",
      found = false,
      age = 29;
```
- js包括五种基本数据类型:`Undefined`, `Null`, `Boolean`, `Number`, `String`和一种复杂类型`Object`（本质是一组无序的键值对组成）
- `typeof`操作符结果有：`undefined`, `boolean`, `string`, `number`, `object`, `function`，`typeof`后可不接圆括号，`typeof null = object`(空的对象引用)。
- `Undefined`类型只有唯一值`undefined`，如用`var`进行变量声明但未初始化时该变量的值即为`undefined`，对未初始化和未声明的变量执行`typeof`操作都返回`undefined`。
- `Null`类型只有唯一值`null`,如果定义的变量用来保存对象，最好将其初始化为`null`,可与`undefined`区分开。
- `undefined == null // true`
- `Boolean`类型有两个字面值`true`和`false`(与`True`,`False`两个**标识符**区分)。对任何数据类型调用Boolean()函数都可返回Boolean值，取决于该数据类型及其对应转化规则

| 数据类型 | 转换为true | 转换为false |
| - |:----:|:----:|
| Boolean | true | false |
| String | 非空字符串 | ""空字符串 |
| Number | 非零数值（无穷大） | 0和NaN |
| Object | 任何对象 | null |
| Undefined | 无 | undefined |
| Null | 无 | null |

- 浮点数值必须包含一个小数点，小数点前可以没数字（不推荐），但小数点后至少有一个数字。
- 保存浮点数的内存空间是保存整值的两倍（1.0会自动解析为1）
- 0.1 + 0.2 = 0.30000000000000004
