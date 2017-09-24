---
title: NexT主题个性化配置
date: 2017-9-24 19:36:50
categories:
- 技术人生
tags:
- hexo
---

> Hexo博客的NexT主题个性化配置记录

本文中提及的**站点配置文件**代指位于博客站点根目录下的`_config.yml`文件，包含对Hexo博客本身的配置，而**主题配置文件**代指位于主题目录下的`_config.yml`文件，配置与主题相关的选项。

<!-- more -->

## 1.设置网站图标Favicon.ico

从网上下载或制作一张(最好是32*32)你喜欢的图标，并将文件名改为`favicon.ico`，放在`/hexo-site/source/`文件夹下，修改主题配置文件：
```
  favicon: /favicon.ico
```

## 2.fork me on github ribbon

打开[此网页](https://github.com/blog/273-github-ribbons)选择一个样式，复制样式对应的代码，粘贴到`themes/next/layout/_layout.swig`文件的`<div class="headband"></div>`这一行代码下面，并将a标签的href属性改成你的github地址。

## 3.修改网站字体大小与行高

打开`\themes\next\source\css\ _variables\base.styl`文件
```
  $font-size-base = 14px     // 修改字体大小
  $line-height-base = 2      // 修改行高
```

## 4.主页和正文的文章添加阴影效果

打开`\themes\next\source\css\_custom\custom.styl`文件，加入以下代码
```css
  .post {
  margin-top: 20px;
  margin-bottom: 20px;
  padding: 25px;
  -webkit-box-shadow: 0 0 5px rgba(202, 203, 203, .5);
  -moz-box-shadow: 0 0 5px rgba(202, 203, 204, .5);
  }
```

## 5.主页文章阅读全文按钮调整

打开`\themes\next\source\css\_custom\custom.styl`文件，加入以下代码
```css
  .post-button {
      margin-top: 20px;
      text-align: right;
  }
```

## 6.网站访问量统计

打开主题配置文件，找到如下代码，并修改
```
  busuanzi_count:
    # count values only if the other configs are false
    enable: true
    # custom uv span for the whole site
    site_uv: true
    site_uv_header: <i class="fa fa-user"> 访客数</i>
    site_uv_footer:
    # custom pv span for the whole site
    site_pv: true
    site_pv_header: <i class="fa fa-eye"> 总访问量</i>
    site_pv_footer:
    # custom pv span for one page only
    page_pv: true
    page_pv_header: <i class="fa fa-eye"> 热度</i>
    page_pv_footer: ℃
```

## 7.打赏字体不闪动

修改文件`\themes\next\source\css\_common\components\post\post-reward.styl`，注释以下代码：
```
/*
  #wechat:hover p{
    animation: roll 0.1s infinite linear;
    -webkit-animation: roll 0.1s infinite linear;
    -moz-animation: roll 0.1s infinite linear;
  }
  #alipay:hover p{
   animation: roll 0.1s infinite linear;
    -webkit-animation: roll 0.1s infinite linear;
    -moz-animation: roll 0.1s infinite linear;
  }
  */
```

## 8.自定义鼠标样式

打开`themes\next\source\css\_custom\custom.styl`文件，添加如下代码：
```css
  * {
      cursor: url("图片地址"),auto!important
  }
  :active {
      cursor: url("图片地址"),auto!important
  }
```
注：url中的图片必须为ico文件

## 9.修改两侧留白的大小

打开`\themes\next\source\css\_variables\base.styl`文件，找到如下代码修改：
```
  $main-desktop                   = 1160px   //
  $main-desktop-large             = 1200px

  $content-desktop                = 900px    //低于1600px的宽度
  $content-desktop-large          = 900px    //大于1600px的宽度
```

## 10.修改顶部加载条样式

打开`themes\next\source\css\_custom\custom.styl`文件，添加如下代码：
```css
  .pace .pace-progress {
      background: #0d0c0c;  /*进度条颜色*/
      height: 3px;
  }
  .pace .pace-progress-inner {
       box-shadow: 0 0 10px #0d0c0c, 0 0 5px     #0d0c0c;  /*阴影颜色*/
  }
  .pace .pace-activity {
      border-top-color: #0d0c0c;    /*上边框颜色*/
      border-left-color: #0d0c0c;    /*左边框颜色*/
  }
```

## 11.h2标题底部横线

打开`themes\next\source\css\_custom\custom.styl`文件，添加如下代码：
```css
  .posts-expand .post-body h2 {
    border-bottom: 1px solid #eee;
  }
```

## 12.自定义代码块样式

打开`themes\next\source\css\_custom\custom.styl`文件，添加如下代码：
```css
  code {
      color: #ff7600;
      background: #fbf7f8;
      margin: 2px;
  }
  /*大代码块的自定义样式*/
  .highlight, pre {
      margin: 5px 0;
      padding: 5px;
      border-radius: 3px;
  }
  .highlight, code, pre {
      border: 1px solid #d6d6d6;
  }
```

## 13.网站侧边栏作者头像旋转

打开`\themes\next\source\css\_common\components\sidebar\sidebar-author.styl`，添加以下代码：
```css
  .site-author-image {
    display: block;
    margin: 0 auto;
    padding: $site-author-image-padding;
    max-width: $site-author-image-width;
    height: $site-author-image-height;
    border: $site-author-image-border-width solid $site-author-image-border-color;

    /* 头像圆形 */
    border-radius: 80px;
    -webkit-border-radius: 80px;
    -moz-border-radius: 80px;
    box-shadow: inset 0 -1px 0 #333sf;

    /* 设置循环动画 [animation: (play)动画名称 (2s)动画播放时长单位秒或微秒 (ase-out)动画播放的速度曲线为以低速结束(1s)等待1秒然后开始动画 (1)动画播放次数(infinite为循环播放) ] */

    /* 鼠标经过头像旋转360度 */
    -webkit-transition: -webkit-transform 1.0s ease-out;
    -moz-transition: -moz-transform 1.0s ease-out;
    transition: transform 1.0s ease-out;
  }

  img:hover {
    /* 鼠标经过停止头像旋转
    -webkit-animation-play-state:paused;
    animation-play-state:paused;*/

    /* 鼠标经过头像旋转360度 */
    -webkit-transform: rotateZ(360deg);
    -moz-transform: rotateZ(360deg);
    transform: rotateZ(360deg);
  }

  /* Z 轴旋转动画 */
  @-webkit-keyframes play {
    0% {
      -webkit-transform: rotateZ(0deg);
    }
    100% {
      -webkit-transform: rotateZ(-360deg);
    }
  }
  @-moz-keyframes play {
    0% {
      -moz-transform: rotateZ(0deg);
    }
    100% {
      -moz-transform: rotateZ(-360deg);
    }
  }
  @keyframes play {
    0% {
      transform: rotateZ(0deg);
    }
    100% {
      transform: rotateZ(-360deg);
    }
  }
```

## 14.修改文章中链接文本样式

修改文件`themes\next\source\css\_common\components\post\post.styl`，在末尾添加如下代码：
```css
.post-body p a {
  color: #0593d3;
  border-bottom: none;
  border-bottom: 1px solid #0593d3;
  &:hover {
    color: #fc6423;
    border-bottom: none;
    border-bottom: 1px solid #fc6423;
  }
}
```
