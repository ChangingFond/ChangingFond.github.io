---
title: CentOS 7 使用 cron 执行计划任务
date: 2018-9-8 12:26:13
categories:
- 技术人生
tags:
- Linux
---

在Linux中，周期执行的任务一般由cron这个守护进程来处理`ps -ef|grep cron`。cron读取一个或多个配置文件，这些配置文件中包含了命令行及其调用时间。cron的配置文件称为 crontab，是 cron table 的简写。

<!-- more -->

## cron服务

CentOS 7下安装
```
    yum install vixie-cron
    yum install crontabs
```
启动服务
```
service crond start
```

开机自动启动
```
chkconfig --level 35 crond on
```

查看是否已加入开机自启动：使用 `chkconfig | grep crond` 看在2 3 4 5级别是不是on
crontab默认就是开机启动的，普通用户要有sudo的权限才能设置开机启动

其他命令
```
　　service crond stop     //关闭服务
　　service crond restart  //重启服务
　　service crond reload   //重新载入配置
　　service crond status   //查看服务状态
```

## 权限

crontab权限问题到`/var/adm/cron/`下查看文件cron.allow和cron.deny是否存在
用法如下：
1、如果两个文件都不存在，则只有root用户才能使用crontab命令。
2、如果cron.allow存在但cron.deny不存在，则只有列在cron.allow文件里的用户才能使用crontab命令，如果root用户也不在里面，则root用户也不能使用crontab。
3、如果cron.allow不存在, cron.deny存在，则只有列在cron.deny文件里面的用户不能使用crontab命令，其它用户都能使用。
4、如果两个文件都存在，则列在cron.allow文件中而且没有列在cron.deny中的用户可以使用crontab，如果两个文件中都有同一个用户，以cron.allow文件里面是否有该用户为准，如果cron.allow中有该用户，则可以使用crontab命令。

CentOS 7 中默认普通用户没有 crontab 权限 ，要想放开普通用户的 crontab 权限可以编辑/var/adm/cron/cron.deny

## crontab用法

crontab命令用于安装、删除或者列出用于驱动cron后台进程的表格。用户把需要执行的命令序列放到crontab文件中以获得执行。每个用户都可以有自己的crontab文件。`/var/spool/cron`下的crontab文件不可以直接创建或者直接修改。该crontab文件是通过crontab命令创建的。

### 系统级crontab

用`ls /etc/cron`然后敲两下TAB，可以看到相关文件及目录。
cron.d/     cron.daily/   cron.hourly/  cron.monthly/ crontab   cron.weekly/

### cron文件目录解读

可以编辑crontab文件，来创建计划任务。
而以daily，hourly，weekly，monthly后缀的目录下分别存放每天，每月，每周，每月执行的任务。
其中存放的就是Shell脚本文件，权限755。我们把要执行的任务写成Shell脚本丢进行相应的目录就可以了。
而不规则周期的计划任务放在corn.d目录下面，可以看做是crontab文件的补充。

### 编辑crontab

注意 crontab 是分用户的，以谁登录就会编辑到哪个用户的 crontab，必须在拥有 cron 权限的用户下编辑 crontab。

```
    crontab -e : 编辑某个用户的crontab文件内容。如果不指定用户，则表示编辑当前用户的crontab文件
    基本格式： *　　*　　*　　*　　*　　command
    对应参数： 分　 时　 日　 月　 周　  命令
    举个例子： 00　00　  *    *    *　  /usr/bin/php /xxx/Timer.php  # 每天凌晨执行PHP脚本

    crontab -r : 从/var/spool/cron目录中删除某个用户的crontab文件，如果不指定用户，则默认删除当前用户的crontab文件

    crontab -l : 显示某个用户的crontab文件内容，如果不指定用户，则表示显示当前用户的crontab文件内容

    crontab -i : 会和-r 配合使用，在删除当前的crontab时询问，输入 y 则删除

    tail -f /var/log/cron : 查看cron日志
```

![](http://changingfond.oss-cn-hangzhou.aliyuncs.com/18-9-8/3612810444.png)

### 特殊符号

"*"代表所有的取值范围内的数字。特别要注意哦！

"/"代表每的意思，如"*/5"表示每5个单位

"-"代表从某个数字到某个数字

","分散的数字

### 举例

```
每晚21：30重启apache
30 21 * * *  service httpd restart

每月的1, 10, 22日的4:55分重启apache, 用，号分割
55 4 1,10,22 * * service httpd restart

每月的1到10日重启apache， 用-号表示区间
* * 1-10 * * service httpd restart

每隔2分钟重启apache ， 这里的 */2 号 表示从0.0秒开始每隔2分钟执行
*/2 * * * * service httpd restart

每晚11点到早上7点每隔1小时重启服务器, 注意分钟是用0而不是* 假如是*则代表每分钟都在执行
0 23-7/1 * * * service httpd restart

每天18点到23点每隔30分钟重启服务器, 两种写法都可以
*/30 18-23 * * * service httpd restart
0,30 18-23 * * * service httpd restart

每天0点执行python3脚本（亲测CentOS 7下在8点执行，由于默认bios时间是utc时间，所以相差了8小时）
00 00 * * * /usr/local/bin/python3 /root/time.py

每天0点执行php脚本
00 00 * * * /usr/bin/php /xxx/Timer.php  # 每天凌晨执行PHP脚本

```

## 参考

- https://www.kancloud.cn/digest/yunwei/212799
- https://segmentfault.com/a/1190000008560453
- https://blog.csdn.net/zd147896325/article/details/80763908
- https://www.cnblogs.com/longjshz/p/5779215.html
- https://www.cnblogs.com/intval/p/5763929.html
