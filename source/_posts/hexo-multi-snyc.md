---
title: Hexo多机同步方案
date: 2017-3-10 10:22:35
updated: 2017-9-10 15:56:50
categories:
- 技术人生
tags:
- git
- hexo
photos:
- http://changingfond.oss-cn-hangzhou.aliyuncs.com/17-3-10/1152358.jpg

---

Hexo博客的本质是将Markdown格式的文章转化成html页面发布到托管容器中，如何将博客的源代码同步到不同机器，实现多机同布博客显得尤为重要。

<!-- more -->

## 具体步骤

1. 在github上创建远程Git仓库，命名为ChangingFond.github.io；
2. 为此仓库创建两个分支，master与hexo；
3. hexo分支用以存放博客源代码，master用以存放生成的静态博客文件（反之亦可）；
4. 克隆ChangingFond.github.io仓库的hexo分支，并将博客源代码文件push；
5. 修改站点配置文件`_config.yml`中的deploy参数
```
    deploy:
        type: git
        repo:
            # 将生成的博客静态文件同步到master分支
            github: git@github.com:ChangingFond/ChangingFond.github.io.git,master  
```

## 使用方法

- 在本地修改博客的源代码（如样式）或发布新博文后
    1.依次执行`git add .` `git commit -m “…”` `git push origin hexo`指令将改动推送到GitHub的hexo分支；
    2.执行`hexo g -d`命令将网站发布到github的master分支或VPS上；

- 当更换机器或者重装电脑（无博客源代码）
    1.使用`git clone -b hexo git@github.com:ChangingFond/ChangingFond.github.io.git`拷贝仓库
    2.在本地新拷贝的`ChangingFond.github.io.git`文件夹下通过`git bash`执行`npm install`指令（无需执行hexo init）
    > 若使用hexo init，则站点的配置文件_config.yml里面内容会被清空使用默认值

    3.在多台电脑上同时写作，只需要在写作之前进行`git pull`，写作之后进行`git push` `hexo g -d`

## 参考资料
- [Hexo使用体验-多机同步发布解决方案](http://eimsteim.github.io/2016/07/03/Hexo%E4%BD%BF%E7%94%A8%E4%BD%93%E9%AA%8C-%E5%A4%9A%E6%9C%BA%E5%90%8C%E6%AD%A5%E5%8F%91%E5%B8%83%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88/)
- [GitHub Pages + Hexo搭建博客](http://crazymilk.github.io/2015/12/28/GitHub-Pages-Hexo%E6%90%AD%E5%BB%BA%E5%8D%9A%E5%AE%A2/)
