---
title: Person Re-identification数据集描述——CUHK03
date: 2018-07-10 11:54:21
categories: 行人重识别
tags:
- Deep Learning
- Person Re-ID
---

![](http://7xwh8v.com1.z0.glb.clouddn.com/18-7-13/96590316.jpg)

<!-- more -->

## 数据集简介

CUHK03是第一个足以进行深度学习的大规模行人重识别数据集，该数据集的图像采集于香港中文大学（CUHK）校园。数据以"cuhk-03.mat"的 MAT 文件格式存储，含有 1467 个不同的人物，由 5 对摄像头采集。

### 目录结构

CUHK-03
　　├── "detected"── 5 x 1 cell
　　　　　　　├── 843x10 cell
　　　　　　　├── 440x10 cell
　　　　　　　├── 77x10 cell
　　　　　　　├── 58x10 cell
　　　　　　　├── 49x10 cell
　　├── "labeled"── 5 x 1 cell
　　　　　　　├── 843x10 cell
　　　　　　　├── 440x10 cell
　　　　　　　├── 77x10 cell
　　　　　　　├── 58x10 cell
　　　　　　　├── 49x10 cell
　　├── "testsets"── 20 x 1 cell
　　　　　　　├── 100 x 2 double matrix

### 目录介绍

（1）"detected"—— 5 x 1 cells，由机器标注，每个 cell 中包含一对摄像头组采集的照片，如下所示：
　　每个摄像头组由 M x 10 cells 组成，M 为行人索引，前 5 列和后 5 列分别来自同一组的不同摄像头。
　　cell 内每个元素为一幅 H x W x 3 的行人框图像(uint8 数据类型)，个别图像可能空缺，为空集。
  - 843x10 cell ——> 摄像头组pair 1。
  - 440x10 cell ——> 摄像头组pair 2。
  - 77x10 cell ——> 摄像头组pair 3。
  - 58x10 cell ——> 摄像头组pair 4。
  - 49x10 cell ——> 摄像头组pair 5。

（2）"labeled"—— 5 x 1 cells，行人框由人工标注，格式和内容和"detected"相同。

（3）"testsets"—— 20 x 1 cells，测试协议，由 20 个 100 x 2 double 类型矩阵组成 (重复二十次)。
　　100 x 2 double，100 行代表 100 个测试样本，第 1 列为摄像头 pair 索引，第 2 列为行人索引。

## 测试协议

CUHK-03的测试协议有两种。

　　第一种为旧的版本(参考文献 [1], 即数据集的出处)，参见数据集中的'testsets'测试协议。具体地说，即随机选出100个行人作为测试集，1160 个行人作为训练集，100 个行人作为验证集（这里总共 1360 个行人而不是 1467 个，这是因为实验中没有用到摄像头组pair 4 和 5 的数据），重复二十次。这种测试协议是 single-shot setting.

　　第二种测试协议(参考文献 [2])类似于 Market-1501 ，它将数据集分为包含 767 个行人的训练集和包含 700 个行人的测试集。在测试阶段，我们随机选择一张图像作为 query，剩下的作为 gallery，这样的话，对于每个行人，有多个 ground truth 在 gallery 中。（新测试协议可以参考[这里](https://github.com/zhunzhong07/person-re-ranking)）

## 下载地址

1. [Google Drive](https://drive.google.com/file/d/0BxJeH3p7Ln48djNVVVJtUXh6bXc/edit?usp=sharing)
2. [Baidu Disk](http://pan.baidu.com/s/1mgklxSc) 密码：rhjq

## State-of-the-art

- [State of the art on the CUHK03](https://github.com/zhunzhong07/person-re-ranking/tree/master/CUHK03-NP)

## Citation

If you use this dataset, please kindly cite the following paper:
```
@inproceedings{li2014deepreid,
  title={DeepReID: Deep Filter Pairing Neural Network for Person Re-identification},
  author={Li, Wei and Zhao, Rui and Xiao, Tong and Wang, Xiaogang},
  booktitle={CVPR},
  year={2014}
}
```

## 参考文献

- Li, W., Zhao, R., Xiao, T., & Wang, X. (2014). Deepreid: Deep filter pairing neural network for person re-identification. In Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (pp. 152-159).
- Zhong Z, Zheng L, Cao D, et al. Re-ranking person re-identification with k-reciprocal encoding[C]//Computer Vision and Pattern Recognition (CVPR), 2017 IEEE Conference on. IEEE, 2017: 3652-3661.
- [zhunzhong07/person-re-ranking](https://github.com/zhunzhong07/person-re-ranking)
- https://blog.csdn.net/hyk_1996/article/details/79387053
- http://www.ee.cuhk.edu.hk/~xgwang/CUHK_identification.html
