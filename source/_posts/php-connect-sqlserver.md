---
title: PHP5.3+配置连接SQL Sever
date: 2016-11-25 10:52:50
updated: 2017-06-12 15:12:22
categories:
- 编程笔记
tags:
- php
- SQL Server
---

- php5.2.x自带php_mssql.dll的扩展连接SQL Server，但这个扩展只能支持SQL Server 2000以下版本。
- php连接方式
```
mssql_connect('localhost', '用户名', '密码');
```
- php5.3.x不再支持php_mssql.dll扩展库

<!--more-->

## PHP5.3+配置SQL Sever

详细配置方式可见 [https://github.com/Microsoft/msphpsql](https://github.com/Microsoft/msphpsql)

## 下载Microsoft Drivers for PHP for SQL Server
进入[https://www.microsoft.com/en-us/download/details.aspx?id=20098](https://www.microsoft.com/en-us/download/details.aspx?id=20098)  
点击download,本人安装的是php环境是5.6.21，选择SQLSRV32.EXE下载

- Version 4.0 supports PHP 7.0+
- Version 3.2 supports PHP 5.6, 5.5, and 5.4
- Version 3.1 supports PHP 5.5 and 5.4
- Version 3.0 supports PHP 5.4.

## 配置Microsoft Drivers for PHP for SQL Server

下载的文件是一个自解压的 EXE文件，将其解压，解压后会新增以下文件
![Markdown](http://7xwh8v.com1.z0.glb.clouddn.com/16/11/19/1.png)

1. 其中54、55、56表示php的5.4.x、5.5.x 和5.6.x版本；
2. vc6或vc9的选择要看你使用的web服务器软件，如果使用的是IIS那就选择vc9，如果是Apache 则选择vc6；
3. ts和nts的选择要看你安装的php版本是线程安全版的还是非线程安全版，ts是线程安全，nts是非线程安全。

选择你对应的扩展拷贝到拷到php/ext目录下，在php.ini文件，添加以下代码：
```
extension=php_pdo_sqlsrv_56_ts.dll（用于pdo）
extension=php_sqlsrv_56_ts.dll
```

## 验证连接
1. 重启服务器，打开phpinfo();看到Registered PHP Streams一栏出现sqlsrv就证明添加扩展成功
2. php连接测试
```
<?php
  $serverName = "(local)";
  $connectionInfo = array("UID"=>"sa","PWD"=>"admin","Database"=>"test");
  $conn = sqlsrv_connect($serverName, $connectionInfo);
  if( $conn ){
     echo "Connection established.\n";
  }else{
     echo "Connection could not be established.\n";
     die(var_dump(sqlsrv_errors()));
  }
  sqlsrv_close($conn);
?>
```
3. yii2连接方式
```
$db = new Connection([  
    'dsn' =＞ 'sqlsrv:Server=youripaddress;Database=xxx',  
    'username' =＞ 'yourusername',  
    'password' =＞ 'yourpassword',  
    'charset' =＞ 'utf8',  
]);  
```
4. 常用函数
sqlsrv_connect
sqlsrv_close
sqlsrv_commit
sqlsrv_errors
sqlsrv_fetch
sqlsrv_fetch_array
sqlsrv_fetch_metadata
sqlsrv_num_rows
sqlsrv_query
sqlsrv_rollback
sqlsrv_rows_affected
具体用法可参见[php官网](http://php.net/manual/en/ref.sqlsrv.php)

## 注意事项

需安装``` ODBC Driver 11 or Microsoft ODBC Driver 13  ```
  - [ODBC Driver 11 下载地址](href="https://www.microsoft.com/en-us/download/details.aspx?id=36434")
  - [ODBC Driver 13 下载地址](href="https://www.microsoft.com/en-us/download/details.aspx?id=50420")

具体安装版本可参见下载页面说明，安装后重启即可。
