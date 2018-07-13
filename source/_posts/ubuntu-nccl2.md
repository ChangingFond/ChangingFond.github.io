---
title: Ubuntu 16.04安装NCCL 2
date: 2018-06-29 10:21:14
categories: 技术人生
tags:
- Deep Learning
- Linux
---

NCCL是Nvidia Collective multi-GPU Communication Library的简称，它是一个实现多GPU的collective communication通信（all-gather, reduce, broadcast）库，Nvidia做了很多优化，以在PCIe、Nvlink、InfiniBand上实现较高的通信速度。本文介绍如何在Ubuntu 16.04 LTS上安装NCCL 2库。

<!-- more -->

## 环境要求

确保您的环境符合以下要求：
- glibc 2.19或更高
- CUDA 8.0或更高版本
- NCCL支持所有具有3.0或更高计算能力的CUDA设备。[如何查看所有NVIDIA GPU的计算能力](https://developer.nvidia.com/cuda-gpus)?

## 安装NCCL

为了下载NCCL，请确保您已注册NVIDIA开发者账号。
  1. 打开[NVIDIA NCCL主页](https://developer.nvidia.com/nccl)。
  2. 点击下载。
  3. 完成简短调查问卷并点击提交。
  4. 接受条款和条件。查看NCCL显示的可用下载版本列表。
  5. 选择您想要安装的NCCL版本。显示可用版本列表。根据您使用的Linux发行版以选择正确的软件包。

### Ubuntu 14.04 LTS和Ubuntu 16.04 LTS
在Ubuntu上安装NCCL需要您首先向包含NCCL软件包的APT系统添加存储库，然后通过APT 安装NCCL软件包，有两个存储库可用——本地存储库和网络存储库。建议选择更新版本以便在发布新版本时轻松升级。

1. 安装存储库
对于本地NCCL存储库：`sudo dpkg -i nccl-repo-<version>.deb`
对于网络存储库：`sudo dpkg -i nvidia-machine-learning-repo-<version>.deb`

2. 更新APT数据库：`sudo apt update`

3. 利用APT安装libnccl2。此外，如果您需要使用NCCL编译应用程序，则同时安装 libnccl-dev包。
如果您正在使用网络存储库，则使用以下命令。
　　`sudo apt install libnccl2 libnccl-dev`
如果您希望保留较旧版本的CUDA，请指定特定版本，例如：
　　`sudo apt-get install libnccl2=2.0.0-1+cuda8.0 libnccl-dev=2.0.0-1+cuda8.0`
请参阅[下载页面](https://developer.nvidia.com/nccl)以了解确切的软件包版本。

### 其他方式

1. 下载tar文件包，将NCCL包解压到您的主目录或`/usr/local`
```
  cd /usr/local
  tar xvf nccl-<version>.txz
```
2. 当编译应用程序时，指定到安装目录路径 NCCL，例如`/usr/local/nccl-<版本>/`。

## 参考资料

- [NCCL Installation Guide :: Deep Learning SDK Documentation](https://docs.nvidia.com/deeplearning/sdk/nccl-install-guide/index.html)
