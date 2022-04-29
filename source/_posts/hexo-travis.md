---
title: 利用 Travis CI 自动部署 Hexo 博客最佳实践
categories: 技术人生
tags: 
- hexo
- vps
date: 2019-10-22 20:16:01
updated: 2019-10-22 20:16:01
photos:
- https://changingfond.oss-cn-hangzhou.aliyuncs.com/19-10-22/travis-ci.png
---
.
<!--more-->

## Travis-CI 介绍

　　CI 即 Continuous Integration，译为持续集成。持续集成指的是只要代码有变更，都会触发 CI 服务器自动对项目运行构建和测试，反馈结果，最终甚至自动部署到测试或生产环境。

　　Travis CI 是一个提供持续集成功能的平台，在 Github 上，可以添加 Travis CI　应用，当有 code push 时候，会推送通知到 Travis，根据设置的脚本运行指定任务。和 Jenkins 不同，Travis CI 是由官方远端提供服务器而无需自己搭建，且只支持 Github，不支持其他代码托管服务。

目前有两个站点:
1. [travis-ci.org](https://travis-ci.org) 对于所有 public 项目完全免费
2. [travis-ci.com](https://travis-ci.com) 只针对 private 项目，提供更多一些额外功能，如 cache，并行 build 个数

> 两个站点只能看到各自的项目，不能通用。

## 步骤

通常更新一篇 Hexo 博客文章，基本流程是：

1. 本地新建 post 页面
2. 在文本编辑器里用 Markdown 语法编辑新建页面
3. 本地生成 public 文件：`hexo g && gulp`
4. 启动本地测试web server：`hexo s --debug`
5. 浏览器打开 `http://localhost:4000/`, 浏览生成文章
6. 如果满意，即可部署到Github page仓库或者 VPS 上：`hexo d`

下面主要介绍如何利用 Travis CI 自动完成第 3-6 步.

### 前置条件

- 生成 SSH key
- 托管 Hexo 博客的 Github仓库，hexo 分支为源代码，master 分支存放生成的静态博客文件。[参考](http://blog.fcj.one/hexo-multi-snyc.html)
- 发布博客的 VPS，并可以通过 hexo-deployer-git 发布。[参考](http://blog.fcj.one/hexo-git-vps.html)
- 已经配置好 gulp 实现博文压缩。[参考](http://blog.fcj.one/hexo-gulp-post.html)

### 开启 Travis CI

直接进入 [travis-ci.org](https://travis-ci.org) 官网，用 Github 账号授权登录。在右上角账户头像处点击进入 Settings，在 Repositories Tab 页点击 Sync now 同步你的 Github 项目。选中 Hexo 博客项目将默认的 off 改变为 on 开启项目的持续集成。
![](https://changingfond.oss-cn-hangzhou.aliyuncs.com/19-10-22/QQ%E6%88%AA%E5%9B%BE20191023193143.jpg)

### 加密 SSH 私钥

　　当 push 到 github 仓库时 travis 自动读取一个名为 `.travis.yml` 配置文件来完成 hexo 的 generate 和 deploy，但是 deploy 需要 VPS 和 Github 的 ssh 写权限，所以需要将 ssh key 上传到项目中，为方便自动化部署，本地系统、Github 和 VPS 上都使用同一套 ssh 公钥和秘钥 （下文的 id_rsa 和 id_rsa.pub）。因为 github 的项目是公开的，需要将 ssh key 加密放到项目中，travis 运行时再解密生成 key，保证秘钥安全性。
　　travis 加密命令是要通过 gem 安装的，gem 依赖 ruby 环境，请确保 ruby 已经安装。gem 在国内不太好访问，建议在 vps 上博客的项目目录里（没有就 clone一个，因为下面的 --add 会修改 .travis.yml ）安装执行下面的命令：

```bash
gem install travis
travis login                        # 使用 github 帐号和密码登录
travis encrypt-file id_rsa  --add   # 加密 id_rsa 私钥，--add 将解密命令添加到 .travis.yml
```

### 集成 build 图标

在 Travis CI 控制台里，点击 build:passing 图标，选择 Markdown 样式，粘贴到项目 Readme 里即可。

### .travis.yml

```bash

language: node_js
node_js: 8
install:
- npm install -g hexo-cli
- npm install -g hexo-deployer-git
- npm install -g gulp
- npm install
addons:
  ssh_known_hosts: host-ip:ssh-port
script:
- hexo g
- gulp
- hexo d
branches:
  only:
  - hexo
before_install:
- openssl aes-256-cbc -K $encrypted_34f58abb81d6_key -iv $encrypted_34f58abb81d6_iv
  -in id_rsa.enc -out ~/.ssh/id_rsa -d
- chmod 600 ~/.ssh/id_rsa

```

配置完成后，以后当你本地编辑完 md 文件后，只需要运行 git push，推送代码到 Github 就会触发 Travis CI 自动生成 build，部署新的博客内容。

## .travis.yml 字段解析

### ssh known_hosts
　　因为 travis-ci 默认只添加了 github.com, gist.github.com 和 ssh.github.com 为 known_hosts，hexo d 执行时会提示是否添加地址到 known_hosts，但是 travis-ci 里不能输入确认，所以需要将服务器的 IP 和端口添加到 known_hosts
```bash
addons:
  ssh_known_hosts: ssh_known_hosts: host-ip:ssh-port
```

## 参考资料

- [https://www.karlzhou.com/2016/05/28/travis-ci-deploy-blog/](https://www.karlzhou.com/2016/05/28/travis-ci-deploy-blog/)
- [https://blog.csdn.net/u012373815/article/details/53574002](https://blog.csdn.net/u012373815/article/details/53574002)
- [https://blog.csdn.net/qq_23079443/article/details/79015225](https://blog.csdn.net/qq_23079443/article/details/79015225)
- [https://segmentfault.com/a/1190000005687985](https://segmentfault.com/a/1190000005687985)
- [http://blog.acwong.org/2016/03/20/auto-deploy-hexo-with-travis-CI/](http://blog.acwong.org/2016/03/20/auto-deploy-hexo-with-travis-CI/)
- [http://www.ruanyifeng.com/blog/2017/12/travis_ci_tutorial.html](http://www.ruanyifeng.com/blog/2017/12/travis_ci_tutorial.html)