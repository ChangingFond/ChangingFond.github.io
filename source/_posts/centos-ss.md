---
title: CentOS 7安装Shadowsocks实现科学上网
date: 2017-9-1 15:37:52
updated: 2017-9-1 15:37:52
categories:
- 技术人生
tags:
- vps
- Linux
---

> 手动搭梯子，跨越GFW。

<!-- more -->

## 搭建环境

- CentOS 7
- Python环境
- Python包管理工具pip

## 安装脚本

使用Xshell5连接到VPS，登录root账户，执行以下命令
```
    wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
    chmod +x shadowsocks.sh
    ./shadowsocks.sh 2>&1 | tee shadowsocks.log
```

安装完成后，提示如下（安装脚本已设置开启自动启动）
```
    Congratulations, shadowsocks install completed!
    Your Server IP:your_server_ip
    Your Server Port:8989
    Your Password:your_password
    Your Local IP:127.0.0.1
    Your Local Port:1080
    Your Encryption Method:aes-256-cfb

    Welcome to visit:http://teddysun.com/342.html
    Enjoy it!
```

## 卸载脚本
root账户登录，执行
```
    ./shadowsocks.sh uninstall
```

## 配置文件

配置文件路径`/etc/shadowsocks.json`

- 单用户配置
```
  {
    "server":"your_server_ip",
    "server_port":8989,
    "local_address":"127.0.0.1",
    "local_port":1080,
    "password":"yourpassword",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
  }
```
- 多用户配置
```
  {
    "server":"your_server_ip",
    "local_address": "127.0.0.1",
    "local_port":1080,
    "port_password":{
         "8989":"password0",
         "9001":"password1",
         "9002":"password2",
         "9003":"password3",
         "9004":"password4"
    },
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
  }
```

## 相关命令

```
  /etc/init.d/shadowsocks start    # 启动
  /etc/init.d/shadowsocks stop     # 停止
  /etc/init.d/shadowsocks restart  # 重启
  /etc/init.d/shadowsocks status   # 状态
```

## 客户端连接

- ### windows客户端
    [Shadowsocks-Win](http://pan.baidu.com/s/1o8aBvL4)  密码：m7bh
    下载后解压，运行，填入配置信息，可查看配置文件`/etc/shadowsocks.json`

- ### 谷歌(360)浏览器 + Proxy SwitchyOmega
  1.安装好SwitchyOmega后，在选项-左侧情景模式点击新建情景模式
  2.选择代理服务器，填写名称（例如Vultr），按下图填写配置后保存
  ![](http://changingfond.oss-cn-hangzhou.aliyuncs.com/17-9-11/51747606.jpg)
  3.再新建情景模式，选择自动切换模式，填写情景模式名称，导入在线列表规则-添加规则列表；
  4.规则列表规则选择第二步配置好的SS，规则列表格式选择AutoProxy；
  5.规则列表网址，填https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt
  ![](http://changingfond.oss-cn-hangzhou.aliyuncs.com/17-9-11/6771281.jpg)

## 参考资料

- [Shadowsocks Python版一键安装脚本](https://teddysun.com/342.html)
