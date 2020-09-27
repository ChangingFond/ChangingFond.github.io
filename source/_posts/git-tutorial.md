---
title: Git 常用命令指南
categories: 编程笔记
tags: Git
date: 2019-3-25 18:12:20
updated: 2020-9-25 17:57:55
photos:
- http://changingfond.oss-cn-hangzhou.aliyuncs.com/19-3-25/git.png
---
*
<!--more-->

## 首次提交代码至远程仓库

### 新建仓库

```
$ git clone repository_url
$ cd project_folder
$ touch README.md
$ git add README.md
$ git commit -m "add README"
$ git push -u origin master
```

### 本地仓库目录已存在

```
$ cd existing_folder
$ git init
$ git remote add origin repository_url
$ git add .
$ git commit -m "Initial commit"
$ git push -u origin master
```

## Git 分支命令

- 查看所有分支
```
$ git branch          #  查看所有分支，当前分支前面会标一个 * 号
```

- 创建新分支
```
$ git checkout -b dev #  相当于以下两条命令
$ git branch dev      #  新建 dev 分支
$ git checkout dev    #  切换到 dev 分支
```

- 切换分支
```
$ git checkout dev    #  切换到 dev 分支
$ git add .
$ git commit -m "dev" #  在 dev 分支上提交
```

- 合并分支
```
$ git checkout master #  切换到主分支
$ git merge dev       #  将 dev 分支合并到当前分支（主分支）
$ git push            #  向远程仓库提交 master 分支
$ git checkout dev    #  切换回 dev 分支
```

- 推送分支
```
$ git push origin dev #  向远程仓库推送 dev 分支
```

- 删除分支
```
$ git brach -d dev    #  删除本地 dev 分支
$ git push orgin :dev #  删除远程 dev 分支
```

## fork 项目后与源项目同步更新

1. 配置上游项目地址。将你 fork 的项目地址配置到自己的项目上。比如我 fork 了一个项目，原项目是 theme-next/hexo-theme-next.git，我的项目就是 ChangingFond/hexo-theme-next.git。使用以下命令来配置。
```
$ git remote add upstream https://github.com/theme-next/hexo-theme-next.git
```

2. 查看一下配置状况，上游项目的地址已经被加进来了。
```
$ git remote -v
origin  git@github.com:ChangingFond/hexo-theme-next.git.git (fetch)
origin  git@github.com:ChangingFond/hexo-theme-next.git.git (push)
upstream    https://github.com/theme-next/hexo-theme-next.git (fetch)
upstream    https://github.com/theme-next/hexo-theme-next.git (push)
```

3. 获取上游项目更新。使用 fetch 命令更新，fetch 后会被存储在一个本地分支 upstream/master 上。
```
$ git fetch upstream
```

4. 合并到本地分支。切换到 master 分支，合并 upstream/master 分支。
```
$ git merge upstream/master
```

5. 提交推送。根据自己情况提交推送自己项目的代码。
```
$ git push origin master
```

6. 由于项目已经配置了上游项目的地址，所以如果 fork 的项目再次更新，重复步骤 3、4、5即可。

## Git 远程分支覆盖本地分支

```
$ git fetch --all
$ git reset --hard origin/master (master 为要拉取的远程分支名)
$ git pull
```
 