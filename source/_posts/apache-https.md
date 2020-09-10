---
title: 利用 Let's Encrypt 配置 Apache SSL 证书
date: 2019-11-19 12:58:24
updated: 2019-11-19 12:58:24
categories:
- 技术人生
tags:
- apache
- Linux
- vps
---

HTTPS（全称：Hyper Text Transfer Protocol over Secure Socket Layer），是以安全为目标的 HTTP 通道，简单讲是 HTTP 的安全版。

即 HTTP 下加入 SSL 层，HTTPS 的安全基础是 SSL，因此加密的详细内容就需要 SSL。

本文介绍如何使用 Let's Encrypt 签发免费证书实现 Apache HTTPS。

<!-- more -->

## Let's Encrypt

Let's Encrypt 是一个由非营利性组织 互联网安全研究小组（ISRG）提供的免费、自动化和开放的证书颁发机构（CA）。

简单的说，借助 Let's Encrypt 颁发的证书可以为我们的网站免费启用 HTTPS(SSL/TLS)。

Let's Encrypt 免费证书的签发/续签都是脚本自动化的，官方提供了几种证书的申请方式方法，点击 [此处](https://letsencrypt.org/docs/client-options/) 快速浏览。

官方推荐使用 Certbot 客户端来签发证书，可以帮我们获取免费的 Let’s Encrypt 证书。Certbot 支持所有 Unix 内核的操作系统。

## 安装 Certbot 并生成证书

```
$ sudo yum install certbot -y
```

安装完成后，可以先通过运行 certbot 进行测试，如无问题则继续下一步。

查看端口是否被占用，有其他服务（例如 Nginx 或者 Apache）占用了 80 端口和 443 端口，就必须先停止这些服务，在证书生成完毕后再启用。
```
$ netstat -tunlp | grep :443
$ netstat -tunlp | grep :80
```

否则在执行下一步生成证书时会报 `Problem binding to port 80: Could not bind to IPv4 or IPv6.`。

接着继续生成证书
```
$ certbot certonly --standalone -d www.fcj.one
```

证书生成完毕后，可以在 `/etc/letsencrypt/live/` 目录下看到对应域名的文件夹找到证书。

这时候我们的第一步生成证书已经完成了，接下来就是配置 Apache 服务器，启用 HTTPS。

## Apache 启用 HTTPS

打开 Apache 安装目录下 conf 目录中的 httpd.conf 文件，找到以下内容并去掉 '#'。

```
LoadModule ssl_module modules/mod_ssl.so
```
如果不存在可手动添加，前提是已经安装 ssl 模块：`yum install mod_ssl`。

然后在 `/etc/httpd/conf/httpd.conf` 添加以下配置：

```
<VirtualHost *:443>
    DocumentRoot "/var/www/html"
    ServerName www.fcj.one
    SSLEngine on
    SSLCertificateFile /etc/letsencrypt/live/www.fcj.one/cert.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/www.fcj.one/privkey.pem
    SSLCertificateChainFile /etc/letsencrypt/live/www.fcj.one/chain.pem
</VirtualHost>
```

重启 Apache 服务器：`service httpd restart`

## 证书续约

Let’s Encrypt 提供的免费证书只有 90 天的有效期，必须在证书到期之前，重新获取这些证书，

certbot 给我们提供了一个很方便的命令 `certbot renew`。 通过这个命令，会自动检查系统内的证书，并且自动更新这些证书。

这里直接用 crontab 设置每月定时更新即可。[crontab 用法参考](http://blog.fcj.one/centos-crontab.html)

```
0 4 * */2 * certbot renew --pre-hook "systemctl stop httpd" --post-hook "systemctl start httpd"
```

每隔两个月凌晨四点进行证书更新，并先行停止 httpd 服务，之后再开启。

## 防火墙开放 443 端口

如果你设置了防火墙，请在防火墙中开启 443 端口。

如果是 firewalld 的可以使用下面命令：
```
sudo firewall-cmd --add-service=http
sudo firewall-cmd --add-service=https
sudo firewall-cmd --runtime-to-permanent
```

如果是iptables的可以使用下面命令
```
sudo iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT
```

## 参考

- https://www.jianshu.com/p/3aa5cb957d9f
- https://blog.csdn.net/qq_20240999/article/details/87618667
- http://www.cnblogs.com/hi-bazinga/archive/2012/04/23/2466605.html
