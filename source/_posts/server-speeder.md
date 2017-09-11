---
title: CentOS 7安装锐速高速上网
date: 2017-9-2 15:46:22
updated: 2017-9-2 15:46:22
categories:
- 技术人生
tags:
- vps
- Linux
---

锐速serverspeeder是一款TCP网络加速软件，能在Linux系统和Windows系统的服务器中安装，安装后能启到提高网络连接稳定性、带宽利用率、低访问失败率等作用，从而提高服务器网络访问速度。锐速并非实际增大服务器带宽，只是提高网络的稳定性和利用率而已。

<!-- more -->

## 安装之前

锐速破解版linux一键自动安装包是由@[91yun](https://github.com/91yun/serverspeeder)发布的，无限带宽版。锐速只支持在XEN和KVM虚拟技术价格的VPS中安装，不支持在OpenVZ虚拟技术架构的VPS安装，推荐在KVM VPS中安装。目前此一键安装包已支持在CentOS，ubuntu和debian系统中安装，而且能自动匹配服务器内核是否支持安装，如果支持就会全自动下载安装，无需任何操作；如果内核不支持，则必须更换合适的VPS内核才能完成安装。

## 内核支持

- CentOS-6.8：2.6.32-642.el7.x86_64
- CentOS-7.2：3.10.0-327.el7.x86_64
- CentOS：4.4.0-x86_64-linode63
- Ubuntu_14.04：4.2.0-35-generic
- Debian_8：3.16.0-4-amd64

## 安装脚本

root账户登录，执行
```
    wget -N –no-check-certificate https://raw.githubusercontent.com/91yun/serverspeeder/master/serverspeeder-all.sh
    bash serverspeeder-all.sh
```

## 卸载脚本

root账户登录，执行
```
    chattr -i /serverspeeder/etc/apx* && /serverspeeder/bin/serverSpeeder.sh uninstall -f
```

## CentOS 7更换内核

CentOS 7支持安装锐速的内核：3.10.0-327.el7.x86_64
root账户登录，执行以下命令

```
  rpm -ivh http://xz.wn789.com/CentOSkernel/kernel-3.10.0-229.1.2.el7.x86_64.rpm --force
  rpm -qa | grep kernel  # 查看内核是否安装成功
```

## 相关命令

```
  service serverSpeeder start     # 启动
  service serverSpeeder stop      # 停止
  service serverSpeeder reload    # 重新加载配置
  service serverSpeeder restart   # 重启
  service serverSpeeder status    # 状态
  service serverSpeeder stats     # 统计
  service serverSpeeder renewLic  # 更新许可文件
  service serverSpeeder update    # 更新
```

## 参考资料

- [如何修改CentOS6、CentOS7内核支持安装锐速的内核](https://www.wn789.com/4689.html)
- [锐速ServerSpeeder无限带宽破解版一键安装包](https://www.wn789.com/4678.html)
