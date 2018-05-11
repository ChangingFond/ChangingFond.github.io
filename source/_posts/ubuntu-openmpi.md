---
title: Ubuntu 16.04安装OpenMPI
date: 2018-05-08 20:08:12
updated: 2018-05-10 21:19:56
categories: 技术人生
tags:
- Deep Learning
- Linux
---

Ubuntu 16.04安装OpenMPI环境

<!-- more -->

## 安装环境

- Ubuntu 16.04
- Intel(R) Core(TM) i7-6800K CPU @ 3.40GHz
- openmpi-1.8.0

## 下载安装包

```
  wget http://www.open-mpi.org/software/ompi/v1.8/downloads/openmpi-1.8.0.tar.gz
```

## 解压缩

```
  tar zxvf openmpi-1.8.0.tar.gz
  cd openmpi-1.8.0
```

## 配置安装文件

```
  # 默认至目录：/usr/local/lib，可自定义安装目录，加参数--prefix="/usr/local/openmpi"
  ./configure --prefix="/usr/local/openmpi"
```

## 安装openMPI

```
  sudo make
  sudo make all install
```

## 配置环境变量

```
  sudo gedit ~/.bashrc
  # 在.bashrc文件的最后加上下面这行
  export PATH=/usr/local/openmpi/bin${PATH:+:${PATH}}
  export LD_LIBRARY_PATH=/usr/local/openmpi/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```

## 测试

```
  cd openmpi-1.8.0/examples
  make
  mpirun -np 4 hello_c
```
