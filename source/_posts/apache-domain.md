---
title: Apache 2 配置二级域名
date: 2018-8-24 14:01:50
categories:
- 技术人生
tags:
- apache
- Linux
- vps
---

本文介绍如何定义二级域名，并在vps的Apache服务器中将域名映射到网站目录下。

<!-- more -->

## 二级域名

一级域名（abc.cn）也称作顶级域名，申请一级域名一般都需要收费。二级域名（blog.abc.cn）是对一级域名的延伸，www其实也是二级域名的一种，只不过大家平时习惯用 www 作为网站的主域名。通过DNS解析服务商，可以在域名管理页面为主域名添加一条解析记录，比如要添加一个 blog 开头的二级域名。

| 主机记录  | 记录类型    |  线路类型  | 记录值 | MX优先级 | TTL |
| -------- | -----   | :----: |  :----: | :----: | :----: |
| blog    | A       | 默认 | 45.54.23.1 | - | 600 |

设置完成后，ping blog.abc.com,如果返回的ip地址都是服务器IP，说明域名解析已经成功。

## Apache配置

方法一：
现将创建的二级域名映射到服务器的某个网站目录下，需要配置apache的http.conf文件，`vi /etc/httpd/conf/httpd.conf`，在文件中增加以下代码：
每一个二级域名对应一个 VirtualHost 标签，有多少二级域名，就需要多少个 VirtualHost 标签。

```
NameVirtualHost *:80

# www

<VirtualHost *:80>
    ServerAdmin 782773117@qq.com
    DocumentRoot /var/www/html/www
    ServerName www.abc.cn
    ErrorLog logs/www-error_log
    CustomLog logs/www-access_log common
</VirtualHost>

# blog

<VirtualHost *:80>
    ServerAdmin 782773117@qq.com
    DocumentRoot /var/www/html/blog
    ServerName blog.abc.cn
    ErrorLog logs/blog-error_log
    CustomLog logs/blog-access_log common
</VirtualHost>
```

方法二：

1.将httpd.conf配置文件的两行取消注释；
```
DocumentRoot "/var/www/html"
ServerAdmin you@example.com
```

2.然后取消Virtual hosts下面的Include注释，引入虚拟服务器配置文件；
```
# Virtual hosts
Include conf/extra/httpd-vhosts.conf
```

3.在配置文件`conf/extra/httpd-vhosts.conf`（若文件不存在则创建）同样加入上述配置内容

最后重启apache服务器，`service httpd restart`

## 参数含义

配置虚拟主机的选项里面，可以出现的参数很多，但最少必须定义DocumentRoot和ServerName。附各个参数含义说明
ServerAdmin  管理员邮箱
DocumentRoot 所需指向路径
ServerName   域名名称
ServerAlias  域名别名 可要可不要
ErrorLog     错误日志
CustomLog    访问日志

## 参考

- http://blog.sina.com.cn/s/blog_5375d76b01014fnt.html
- https://segmentfault.com/a/1190000007512622
- http://www.cnblogs.com/hi-bazinga/archive/2012/04/23/2466605.html
