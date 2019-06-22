---
title: Git 常用命令指南
categories: 编程笔记
tags: Git
date: 2019-3-25 18:12:20
photos:
- http://changingfond.oss-cn-hangzhou.aliyuncs.com/19-3-25/git.png
---


<!--more-->

## 首次提交代码至远程仓库

### Create a new repository
```
$ git clone repository_url
$ cd project_folder
$ touch README.md
$ git add README.md
$ git commit -m "add README"
$ git push -u origin master
```
### Existing folder
```
$ cd existing_folder
$ git init
$ git remote add origin repository_url
$ git add .
$ git commit -m "Initial commit"
$ git push -u origin master
```

## git 分支命令

### 查看所有分支
```
$ git branch          #  查看所有分支，当前分支前面会标一个 * 号
```

### 创建新分支
```
$ git checkout -b dev #  相当于以下两条命令
$ git branch dev      #  新建 dev 分支
$ git checkout dev    #  切换到 dev 分支
```

### 切换分支
```
$ git checkout dev    #  切换到 dev 分支
$ git add .
$ git commit -m "dev" #  在 dev 分支上提交
```

### 合并分支
```
$ git checkout master #  切换到主分支
$ git merge dev       #  将 dev 分支合并到当前分支（主分支）
$ git push            #  向远程仓库提交 master 分支
$ git checkout dev    #  切换回 dev 分支
```

### 推送分支
```
$ git push origin dev #  向远程仓库推送 dev 分支
```

### 删除分支
```
$ git brach -d dev    #  删除本地 dev 分支
$ git push orgin :dev #  删除远程 dev 分支
```
