---
title: CentOS 7安装MongoDB数据库
date: 2017-10-14 21:42:35
categories:
- 技术人生
tags:
- Linux

---

在CentOS 7服务器上安装MongoDB数据库，并设置开机启动。

<!-- more -->

## 下载安装包

1. 打开MongoDB官网[下载地址](https://www.mongodb.com/download-center#community)
2. 选择对应的版本和系统环境，获取下载链接，如CentOS 7的下载链接为`https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-3.4.9.tgz`
3. 运行
```
  wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-3.4.9.tgz
  tar zxvf mongodb-linux-x86_64-rhel70-3.4.9.tgz   # 解压
  mv mongodb-linux-x86_64-rhel70-3.4.9 /usr/src/mongodb  # 移动
```

## 创建数据文件路径

```
  cd /usr/src/mongodb
  mkdir db
  mkdir logs
  # 修改权限
  chmod -R 755 db
  chmod -R 755 logs
  chmod -R 755 bin
```

## 创建配置文件

```
  cd bin
  vi mongodb.conf

  # 添加以下内容
  dbpath=/usr/src/mongodb/db  # 数据文件路径
  logpath=/usr/src/mongodb/logs/mongodb.log # 日志文件路径
  port=27017  # 端口(默认)
  fork=true   # 开启守护进程
  logappend=true  # 追加日志
  nohttpinterface=true  # 关闭http接口
```

## 启动测试

```
  # 启动数据库
  cd /usr/src/mongodb/bin
  ./mongod -f ./mongodb.conf

  # 测试
  ./mongo 127.0.0.1

  # 启动成功
  MongoDB shell version: 2.4.9
  connecting to: 127.0.0.1/test  
```

注意： 使用外部工具连接mongodb数据库前，应先开启vps的防火墙27017端口
```
  # 开启端口  
  firewall-cmd --zone=public --add-port=27017/tcp --permanent  
  # 查看端口  
  firewall-cmd --permanent --query-port=27017/tcp  
  # 重启防火墙  
  firewall-cmd --reload
```

## 设置开机自动启动

```
  # 注册自定义服务
  cd /lib/systemd/system  
  vi mongodb.service

  # 添加以下内容
  ***********************************
  [Unit]

  Description=mongodb
  After=network.target remote-fs.target nss-lookup.target

  [Service]
  Type=forking
  ExecStart=/usr/src/mongodb/bin/mongod -f /usr/src/mongodb/bin/mongodb.conf
  ExecReload=/bin/kill -s HUP $MAINPID
  ExecStop=/usr/src/mongodb/bin/mongod --shutdown -f  /usr/src/mongodb/bin/mongodb.conf
  PrivateTmp=true

  [Install]  
  WantedBy=multi-user.target
  ***********************************

  # 修改权限
  chmod 754 mongodb.service  

  # 服务命令
  systemctl start mongodb.service   # 启动服务  
  systemctl stop mongodb.service    # 关闭服务
  systemctl enable mongodb.service  # 开机启动  
```

## 添加管理员与用户认证

MongoDB数据库的用户权限分为以下四种：
  - userAdminAnyDatabase 拥有分配角色和用户的权限，但没有读写的权限
  - root 这是超级管理员
  - readWrite 有读写权限
  - read 有读权限

1.开启MongoDB数据库，运行`/usr/src/mongodb/bin/mongo`，`use admin`进入admin数据库，创建管理员账户
```
  db.createUser(
    {
      user: "root",
      pwd: "pwd",
      roles: [ { role: "root", db: "admin" } ]
    })

  db.system.users.find() # 查看所有用户
```
2.修改配置文件mongodb.conf，在最下面加入一行`auth = on`，重启mongodb，进入`admin`数据库再运行`show dbs`发现已经没有权限
3.此时需要对数据库进行权限认证，运行`db.auth('root', 'pwd')`，返回1表示成功
4.对于具体的数据库，创建用户与上述步骤相同，角色不同。
