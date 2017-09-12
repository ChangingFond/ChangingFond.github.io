---
title: VPS配置Git Hooks实现hexo博客更新
date: 2017-9-7 14:55:50
updated: 2017-9-7 21:33:50
categories:
- 技术人生
tags:
- vps
- git
- hexo
- Linux
---

客户端使用Hexo生成静态文件，通过Git推送到VPS的Git仓库。VPS配置Git Hooks,将静态文件同步到站点目录，实现hexo博客更新。

<!-- more -->

## 本机准备工作

- 安装Hexo环境
- 安装Git
- 生成ssh秘钥

## VPS配置工作

VPS以CentOS 7为例，使用Xshell5连接到VPS，登录root账户。

### 安装Git

```bash
    git --version    # 查看系统是否安装git
    yum install git  # 安装git
    yum remove git   # 卸载git
```

### 新建用户

```bash
    adduser git
    chmod 740 /etc/sudoers
    vi /etc/sudoers
```
在vi编辑器中找到如下行

```bash
    ## Allow root to run any commands anywhere
    root    ALL=(ALL)     ALL
```

在下面新增一行

```bash
    git   ALL=(ALL)     ALL
```

保存后退出(linux命令 :wq)，执行

```bash
    chmod 440 /etc/sudoers
```

### 新建git仓库

```bash
    su git
    cd ~
    mkdir .ssh && cd .ssh
    touch authorized_keys
    vi authorized_keys   # 粘贴进本地机器的ssh公钥（一般在C:\Users\用户名\.ssh\id_rsa.pub文件中）
    cd ~
    mkdir hexo.git && cd hexo.git
    git init --bare      # 初始化git仓库
```

### ssh连接测试

在`git bash`命令行中输入`ssh git@VPS的IP地址`，如果能登录远程主机，则表示Git配置成功

> ssh可同时支持publickey和password两种授权方式，publickey默认不开启，开启配置为yes。
如果客户端不存在.ssh/id_rsa，则使用password授权。
存在则使用publickey授权；如果publickey授权失败，依然会继续使用password授权。

### 赋予git用户对网站目录的权限

```bash
    cd /var/www/html                        # apache服务器的网站根目录
    mkdir blog                              # 新建blog文件夹用以放置hexo博客文件
    chown git:git -R /var/www/html/blog     # 将目录所有者改为git用户
```

### 配置Git Hooks

```bash
  su git
  cd /home/git/hexo.git/hooks
  touch post-receive      #  新建脚本文件
  vi post-receive
```

在vi编辑中输入以下代码后保存退出

```bash
#!/bin/bash
  GIT_REPO=/home/git/hexo.git    # git仓库
  TMP_GIT_CLONE=/tmp/hexo
  PUBLIC_WWW=/var/www/html/blog  # 网站目录
  rm -rf ${TMP_GIT_CLONE}
  git clone $GIT_REPO $TMP_GIT_CLONE
  rm -rf ${PUBLIC_WWW}/*
  cp -rf ${TMP_GIT_CLONE}/* ${PUBLIC_WWW}
  chmod +x post-receive          # 赋予脚本的执行权限
```

## 本机配置工作

进入本地hexo博客文件夹，打开站点配置文件`_config.yml`,修改deploy选项

```bash
deploy:
  type: git
  repo:
    github: git@github.com:ChangingFond/ChangingFond.github.io.git  #同步到GitHub
    vps: git@vps的ip:hexo.git仓库地址,master  #同步到自己的VPS
  branch: master
  message: Hexo Blog updated - {{ now('YYYY-MM-DD HH:mm:ss') }})
```

按住shift右击，选择在此处打开命令窗口，运行`hexo g -d`,如果一切正常，静态文件已经被成功的push到了blog的仓库里。
至此，我们完成了通过git将hexo博客部署到VPS上的功能。

## 参考资料

感谢以下作者的文章对笔者的帮助
- [在VPS上搭建hexo博客，利用git更新](http://tiktoking.github.io/2016/01/26/hexo/)
- [VPS(CentOS)搭建Hexo博客与Git Hooks更新](https://www.hansoncoder.com/2016/03/02/VPS-building-Hexo/)
- [开始新的折腾，Hexo博客Git-VPS部署完整记录](http://sobaigu.com/Hexo-git-to-vps.html)

## 常见问题

- #### ssh使用公钥授权免密登录不通过Permission denied(publickey,gssapi-keyex,gssapi-with-mic)

    尝试以下步骤：
    1.运行`vi /etc/ssh/sshd_config`，找到以下代码，按如下格式修改
    ```bash
        RSAAuthentication yes  
        PubkeyAuthentication yes  
        AuthorizedKeysFile  .ssh/authorized_keys  
    ```
    保存后退出，重启sshd服务
    ```bash
        # sshd服务相关命令
        systemctl restart sshd.service
        systemctl status sshd.service   # 查看ssh服务的状态
        systemctl start sshd.service    # 开启ssh服务
        sytemctl enable sshd.service    # ssh服务随开机启动，反之disabled
        systemctl stop sshd.ervice      # 停止ssh服务
        ```
    2.修改文件夹以及文件权限
    ```bash
        chmod 700 /home/git/.ssh
        chmod 644 /home/git/.ssh/authorized_keys
    ```
    3.关闭SELinux
    ```bash
        setenforce 0            # 暂时关闭，重启后恢复

        vi /etc/selinux/config  # 永久关闭
        SELINUX=disabled  
    ```
