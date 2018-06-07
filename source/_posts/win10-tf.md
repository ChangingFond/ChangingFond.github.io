---
title: Windows 10安装Cuda9、Cudnn7配置Tensorflow 1.8环境
date: 2018-05-10 19:27:13
categories: 技术人生
tags:
- Cuda
- Windows
- Deep Learning
---

Windows 10安装Cuda9.0、Cudnn7.0，配置Tensorflow r1.8环境步骤全记录。
当前安装时间：2018年5月10日

<!-- more -->

## 安装环境

- Windows 10
- Intel(R) Core(TM) i7-6800K CPU @ 3.40GHz
- 2 * NVIDIA GTX 1080 Ti
- Tensorflow r1.8
- CUDA 9.0、Cudnn 7.0
- Python 3.6

## 安装CUDA

　　下载CUDA对应版本：https://developer.nvidia.com/cuda-toolkit-archive，选择**CUDA Toolkit 9.0 (Sept 2017)->Windows->x86_64->10->exe(local)
　　下载完成后，打开直接点击next下一步进行安装，安装路径默认为C盘

## 配置Cuda环境变量

1. 右击“我的电脑”，选择“属性”，点击“高级系统设置”
2. 选择“环境变量”，在“系统变量”框中找到“path”，点击选中，并点击“编辑”按钮
3. 点击“新建”按钮，添加以下路径
　　`C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v9.0\bin`
　　`C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v9.0\libnvvp`
　　`C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v9.0\lib\x64`
　　`C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v9.0\extras\CUPTI\libx64`
4. 命令行输入`nccv -V`检查是否成功

## 安装Cudnn

　　进入 https://developer.nvidia.com/rdp/cudnn-archive ，选择对应的7.0版本下载即可。
　　解压压缩包，把压缩包中bin,include,lib中的文件分别拷贝到C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v9.0目录的对应目录下。

## 安装TensorFlow-gpu

```
  pip install tensorflow-gpu
```

## 参考链接

- [win10+cuda9.0+cuDNN 7.0+Tensorflow1.5（GPU）安装](https://blog.csdn.net/zw__chen/article/details/79374467)
