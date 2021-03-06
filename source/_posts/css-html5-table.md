﻿---
title: CSS解决表格单元格内容过多的问题
date: 2016-11-25 10:52:50
updated: 2017-06-08 17:12:22
categories:
- 编程笔记
tags:
- Frontend
- css
---

最近在实验室开发前端页面，从PHP后端传递数据渲染视图中的一个表格时，发现表格中某些单元格数据内容过多影响了页面美观，想让多余的内容用省略号代替。

<!-- more -->

## CSS样式

```
table {
　　table-layout: fixed;
}

td {
　　white-space: nowrap;
　　overflow: hidden;
　　text-overflow: ellipsis;
}
```

## 代码解释

```table-layout: fixed```  由于table-layout的默认值是auto，即table的宽高将取决于其内容的多寡，如果内容的体积无法估测，那么最终表格的呈现形式也无法保证了，fixed一下就好了。（注意：此样式为关键）

```white-space: nowrap```  为了保证无论单元格（TD）中文本内容有多少，都不会自动换行，此时多余的内容会在水平方向撑破单元格。

```overflow: hidden```  隐藏超出单元格的部分。

```text-overflow: ellipsis``` 将被隐藏的那部分用省略号代替。
***
