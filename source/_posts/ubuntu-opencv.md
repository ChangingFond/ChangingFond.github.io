---
title: Ubuntu 16.04安装配置OpenCV 2.4.9
date: 2018-05-11 12:30:12
categories: 技术人生
tags:
- Deep Learning
- Linux
---

Ubuntu 16.04安装配置OpenCV 2.4.9

<!-- more -->

## 安装环境

- Ubuntu 16.04
- Intel(R) Core(TM) i7-6800K CPU @ 3.40GHz
- opencv-2.4.9

## 安装依赖

```
  sudo apt-get install build-essential
  sudo apt-get install libgtk2.0-dev libavcodec-dev libavformat-dev libtiff4-dev libswscale-dev libjasper-dev  # 图片视频支持
  sudo apt-get install cmake       # 安装cmake
  sudo apt-get install pkg-config  # 提供从源代码中编译软件时查询已安装的库时使用的统一接口
```

## 下载安装包

　　下载[opencv2.4.9](https://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.9/opencv-2.4.9.zip/download)安装包至你的路径
```
  unzip opencv-2.4.9.zip
  cd opencv-2.4.9
  mkdir release
  cd release
  # 下面这行cmake参数网上有多种选择，此处选择不包含CUDA和EIGEN，避免后续编译出错。默认安装至/usr/local目录下
  cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_CUDA=OFF -D WITH_OPENMP=ON -D WITH_QT=ON -D WITH_EIGEN=OFF ..
```

## 编译

```
  sudo make -j4
  sudo make install
```

## 配置

```
  # 默认至目录：/usr/local/lib，可自定义安装目录，加参数--prefix="/usr/local/openmpi"
  sudo vi /etc/ld.so.conf.d/opencv.conf
  # 添加一行
  /usr/local/lib
  sudo ldconfig -v
```

## 测试

```
  cd opencv-2.4.9/samples/c
  ./build_all.sh
  ./find_obj
```

## 参考链接

- [Ubuntu16.04 caffe Opencv2.4.13 GPU环境配置](https://blog.csdn.net/sinat_17196995/article/details/53466524)
- [Opencv 2.4.9在Ubuntu下的配置与安装](https://blog.csdn.net/surgewong/article/details/39078251)
