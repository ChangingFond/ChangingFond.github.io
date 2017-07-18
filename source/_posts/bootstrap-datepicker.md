---
title: bootstrap-datepicker插件汉化
date: 2016-10-27 19:21:29
categories:
- 编程笔记
tags:
- Frontend
- JavaScript
---

近期在做项目时用到bootstrap-datepicker这个插件，默认英文显示日期，查阅相关资料后改动即可汉化

- 先将bootstrap-datepicker.js另存为UTF-8编码格式
- 增加cn语言选项

``` javascript
var dates = $.fn.datepicker.dates = {
  en: {
    days: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
    daysShort: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
    daysMin: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"],
    months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
    monthsShort: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
    today: "Today",
    clear: "Clear"
  },
  cn: {
    days: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
    daysShort: ["日", "一", "二", "三", "四", "五", "六", "七"],
    daysMin: ["日", "一", "二", "三", "四", "五", "六", "七"],
    months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
    monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
    today: "今天",
    clear: "清除"
  }
};
```
- 修改默认语言参数language为cn

``` javascript

var defaults = $.fn.datepicker.defaults = {
	autoclose: false,
	beforeShowDay: $.noop,
	calendarWeeks: false,
	clearBtn: false,
	daysOfWeekDisabled: [],
	endDate: Infinity,
	forceParse: true,
	format: 'mm/dd/yyyy',
	keyboardNavigation: true,
	language: 'cn',
	minViewMode: 0,
	orientation: "auto",
	rtl: false,
	startDate: -Infinity,
	startView: 0,
	todayBtn: false,
	todayHighlight: false,
	weekStart: 0
    };
```
即可完成对bootstrap-datepicker插件的汉化。
