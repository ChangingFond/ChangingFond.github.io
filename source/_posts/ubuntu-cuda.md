---
title: Ubuntu 16.04安装Cuda、Cudnn配置Caffe环境
date: 2018-04-14 20:04:13
categories: 技术人生
tags:
- Cuda
- Linux
---

Ubuntu16.04安装Cuda8.0、Cudnn6.0，配置Caffe环境步骤全记录

<!-- more -->

## 安装环境

- Ubuntu 16.04
- Intel(R) Core(TM) i7-6800K CPU @ 3.40GHz
- 2 * NVIDIA GTX 1080 Ti

## 安装依赖包

```
  sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
  sudo apt-get install --no-install-recommends libboost-all-dev
  sudo apt-get install libopenblas-dev liblapack-dev libatlas-base-dev
  sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev
  sudo apt-get install git cmake build-essential
```
有一定几率安装失败而导致后续步骤出现问题，要确保以上依赖包都已安装成功，验证方法就是重新运行安装命令
如验证`git cmake build-essential`是否安装成功则再次运行以下命令：`sudo apt-get install git cmake build-essential`
界面提示如下则说明已成功安装依赖包，否则继续安装直到安装成功。
```
  test@GTX1080Ti:~$ sudo apt-get install git cmake build-essential
  正在读取软件包列表... 完成
  正在分析软件包的依赖关系树       
  正在读取状态信息... 完成       
  build-essential 已经是最新版 (12.1ubuntu2)。
  cmake 已经是最新版 (3.5.1-1ubuntu3)。
  git 已经是最新版 (1:2.7.4-0ubuntu1.1)。
  下列软件包是自动安装的并且现在不需要了：
    lib32gcc1 libc6-i386
  使用'sudo apt autoremove'来卸载它(它们)。
  升级了 0 个软件包，新安装了 0 个软件包，要卸载 0 个软件包，有 94 个软件包未被升级。
```

## 安装Cuda 8.0

　　进入 https://developer.nvidia.com/cuda-downloads ，依次选择 CUDA 类型然后下载即可。
　　下载的CUDA安装中包含有 nvidia 显卡驱动，故此步骤 CUDA 的安装包括了 nvidia 显卡驱动的安装，此时注意你是否已经安装过 nvidia 显卡驱动，若无法保证已安装的 nvidia 显卡驱动一定正确，那就卸载掉之前安装的 nvidia 显卡驱动，然后开始安装 CUDA 8.0；若可以保证已安装正确的 nvidia 显卡驱动，则直接开始安装 CUDA 8.0，在安装过程中选择不再安装 nvidia 显卡驱动。
　　为了方便开始安装过程的路径查找，把下载的 CUDA 安装文件移动到 HOME 路径下，然后通过 Ctrl + Alt + F1 进入文本模式，输入帐号密码登录，通过 Ctrl + Alt + F7 可返回图形化模式，然后运行 CUDA 安装文件进行安装，之前我们已经把 CUDA 安装文件移动至 HOME，直接通过 sh 命令运行安装文件即可：
　　`sudo sh cuda_8.0.61_375.26_linux.run --no-opengl-libs`
　　其中 cuda_8.0.61_375.26_linux.run 是我的 CUDA 安装文件名，而你需替换为自己的 CUDA 安装文件名。
　　执行此命令约1分钟后会出现 0%信息，此时长按回车键让此百分比增长，直到100%，然后按照提示操作即可，先输入 accept ，然后让选择是否安装 nvidia 驱动，这里的选择对应第5步开头，若未安装则输入 “y”，若确保已安装正确驱动则输入“n”。
　　剩下的选择则都输入“y”确认安装或确认默认路径安装，开始安装，此时若出现安装失败提示则可能为未关闭桌面服务或在已安装 nvidia 驱动的情况下重复再次安装 nvidia 驱动，安装完成后输入`reboot`命令重启：

## 配置环境变量

重启后登录进入系统，配置 CUDA 环境变量
终端输入：`sudo gedit ~/.bashrc`
在该文件最后加入以下两行并保存：
　　`export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}`
　　`export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}`
使该配置生效：`source ~/.bashrc`

终端输入：`sudo gedit /etc/profile`
文件末尾加入：`export PATH="/usr/local/cuda/bin:$PATH"`
运行：`source /etc/profile`，查看是否有误

## 设置动态链接库

终端输入：`sudo gedit /etc/ld.so.conf.d/cuda.conf`
添加：`/usr/local/cuda/lib64`
执行生效：`sudo ldconfig`

## 测试Cuda samples

```
  cd /usr/local/cuda/samples/1_Utilities/deviceQuery
  make
  sudo ./deviceQuery
```

## 安装Cudnn 6.0

1. 确定已经安装的Cuda版本，以Cuda8.0为例，到官网 https://developer.nvidia.com/rdp/cudnn-download 下载相应的库文件
2. 下载后进行解压
3. 进入include文件夹，执行`sudo cp cudnn.h /usr/local/cuda/include/   # 复制头文件`
4. 进入lib64文件夹，执行`sudo cp lib* /usr/local/cuda/lib64/          # 复制动态链接库`
5. 执行
```
cd /usr/local/cuda/lib64/
sudo rm -rf libcudnn.so libcudnn.so.6           # 删除原有动态文件
sudo ln -s libcudnn.so.6.0.21 libcudnn.so.6     # 生成软链接
sudo ln -s libcudnn.so.6 libcudnn.so            # 生成软链接

locate libcudnn.so                              # 查看安装位置
```
安装完成后可用 `nvcc -V` 命令验证是否安装成功

## 安装caffe

从git中clone出源码后，修改Makefile.config：
　　`cp Makefile.config.example Makefile.config`
　　`vi Makefile.config`
找到`#USE_CUDNN := 1`,取消注释（设置为GPU模式）

找到
　　`INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include`
　　`LIBRARY_DIRS := $(PYTHON_LIB) /usr/local/lib /usr/lib`
修改为
　　`INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include /usr/include/hdf5/serial`
　　`LIBRARY_DIRS := $(PYTHON_LIB) /usr/local/lib /usr/lib /usr/lib/x86_64-linux-gnu/hdf5/serial`

在 caffe 目录下执行 ：
　　`make all -j8`
编译成功后可运行测试：
　　`make runtest -j8`
