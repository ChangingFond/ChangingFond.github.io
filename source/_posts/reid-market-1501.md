---
title: Person Re-identification数据集描述——Market-1501
date: 2018-07-12 10:13:12
categories: 行人重识别
tags:
- Deep Learning
- Person Re-ID
---

![dataset](http://7xwh8v.com1.z0.glb.clouddn.com/18-7-12/87140649.jpg)

<!-- more -->

## 数据集简介

　　Market-1501 数据集在清华大学校园中采集，夏天拍摄，在 2015 年构建并公开。它包括由6个摄像头（其中5个高清摄像头和1个低清摄像头）拍摄到的 1501 个行人、32668 个检测到的行人矩形框。每个行人至少由2个摄像头捕获到，并且在一个摄像头中可能具有多张图像。训练集有 751 人，包含 12,936 张图像，平均每个人有 17.2 张训练数据；测试集有 750 人，包含 19,732 张图像，平均每个人有 26.3 张测试数据。3368 张查询图像的行人检测矩形框是人工绘制的，而 gallery 中的行人检测矩形框则是使用DPM检测器检测得到的。该数据集提供的固定数量的训练集和测试集均可以在single-shot或multi-shot测试设置下使用。

### 目录结构

Market-1501
　　├── bounding_box_test
　　　　　　　├── 0000_c1s1_000151_01.jpg
　　　　　　　├── 0000_c1s1_000376_03.jpg
　　　　　　　├── 0000_c1s1_001051_02.jpg
　　├── bounding_box_train
　　　　　　　├── 0002_c1s1_000451_03.jpg
　　　　　　　├── 0002_c1s1_000551_01.jpg
　　　　　　　├── 0002_c1s1_000801_01.jpg
　　├── gt_bbox
　　　　　　　├── 0001_c1s1_001051_00.jpg
　　　　　　　├── 0001_c1s1_009376_00.jpg
　　　　　　　├── 0001_c2s1_001976_00.jpg
　　├── gt_query
　　　　　　　├── 0001_c1s1_001051_00_good.mat
　　　　　　　├── 0001_c1s1_001051_00_junk.mat
　　├── query
　　　　　　　├── 0001_c1s1_001051_00.jpg
　　　　　　　├── 0001_c2s1_000301_00.jpg
　　　　　　　├── 0001_c3s1_000551_00.jpg
　　└── readme.txt

### 目录介绍

1） "bounding_box_test"——用于测试集的 750 人，包含 19,732 张图像，前缀为 0000 表示在提取这 750 人的过程中DPM检测错的图（可能与query是同一个人），-1 表示检测出来其他人的图（不在这 750 人中）
2） "bounding_box_train"——用于训练集的 751 人，包含 12,936 张图像
3） "query"——为 750 人在每个摄像头中随机选择一张图像作为query，因此一个人的query最多有 6 个，共有 3,368 张图像
4） "gt_query"——matlab格式，用于判断一个query的哪些图片是好的匹配（同一个人不同摄像头的图像）和不好的匹配（同一个人同一个摄像头的图像或非同一个人的图像）
5） "gt_bbox"——手工标注的bounding box，用于判断DPM检测的bounding box是不是一个好的box

### 命名规则

以 0001_c1s1_000151_01.jpg 为例
1） 0001 表示每个人的标签编号，从0001到1501；
2） c1 表示第一个摄像头(camera1)，共有6个摄像头；
3） s1 表示第一个录像片段(sequece1)，每个摄像机都有数个录像段；
4） 000151 表示 c1s1 的第000151帧图片，视频帧率25fps；
5） 01 表示 c1s1_001051 这一帧上的第1个检测框，由于采用DPM检测器，对于每一帧上的行人可能会框出好几个bbox。00 表示手工标注框

## 测试协议

Cumulative Matching Characteristics (CMC) curves 是目前行人重识别领域最流行的性能评估方法。考虑一个简单的 single-gallery-shot 情形，每个数据集中的ID(gallery ID)只有一个实例. 对于每一次的识别(query), 算法将根据要查询的图像(query) 到所有gallery samples的距离从小到大排序，CMC top-k accuracy 计算如下：

                                Acc_k = 1, if top-k ranked gallery samples contain query identity
                                Acc_k = 0, otherwise

这是一个 shifted step function, 最终的CMC 曲线(curve) 通过对所有queries的shifted step functions取平均得到。尽管在 single-gallery-shot 情形下，CMC 有很明确的定义，但是在 multi-gallery-shot 情形下，它的定义并不明确，因为每个gallery identity 可能存在多个instances.

Market-1501中 Query 和 gallery 集可能来自相同的摄像头视角，但是对于每个query identity, 他/她的来自同一个摄像头的 gallery samples 会被排除掉。对于每个 gallery identity，他们不会只随机采样一个instance. 这意味着在计算CMC时， query 将总是匹配 gallery 中“最简单”的正样本，而不关注其他更难识别的正样本。bounding_box_test 文件夹是 gallery 样本，bounding_box_train 文件夹是 train 样本，query 文件夹是 query 样本

由上面可以看出，在 multi-gallery-shot 情形下，CMC评估具有缺陷。因此，也使用 mAP（mean average precsion）作为评估指标。mAP可认为是PR曲线下的面积，即平均的查准率。

- [Market-1501 Evaluation Code](https://github.com/HejaBVB09/Market1501Evaluation)

## 下载地址

1. [Google Drive](https://drive.google.com/file/d/0B8-rUzbwVRk0c054eEozWG9COHM/view?usp=sharing)
2. [Baidu Disk](https://pan.baidu.com/s/1ntIi2Op)

## State of the art

- [State of the art on the Market-1501 dataset](http://www.liangzheng.org/Project/state_of_the_art_market1501.html)

## Citation

If you use this dataset, please kindly cite this paper:
```
@inproceedings{zheng2015scalable,
  title={Scalable Person Re-identification: A Benchmark},
  author={Zheng, Liang and Shen, Liyue and Tian, Lu and Wang, Shengjin and Wang, Jingdong and Tian, Qi},
  booktitle={Computer Vision, IEEE International Conference on},
  year={2015}
}
```

## 参考文献

- Zheng, Liang, et al. "Scalable Person Re-identification: A Benchmark." IEEE International Conference on Computer Vision IEEE Computer Society, 2015:1116-1124.
- [Liang Zheng](http://www.liangzheng.org/Project/project_reid.html)
- [Person re-ID](http://bigbrothersue.com/index.php/2017/12/20/person-re-id/)
