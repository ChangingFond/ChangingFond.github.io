---
title: 获取指定路径下的文件类型及数量
date: 2016-12-13 20:12:30
categories:
- 编程笔记
tags:
- C#
---

C#实现指定路径，扫描该路径下所有文件，统计文件类型及其对应数量

<!-- more -->

```
using System;
using System.Collections.Generic;
using System.IO;

namespace FileExtensionScan
{
    class Program
    {
        Dictionary<String, int> pList = new Dictionary<String, int>(); //字典形式{后缀：数量}
        int fileNum = 0;

        public void GetFileNum(string srcPath)
        {
            try
            {
                // 得到源目录的文件列表，该里面是包含文件以及目录路径的一个数组
                string[] fileList = System.IO.Directory.GetFileSystemEntries(srcPath);
                // 遍历所有的文件和目录
                foreach (string file in fileList)
                {
                    // 先当作目录处理如果存在这个目录就重新调用GetFileNum(string srcPath)
                    if (Directory.Exists(file))
                        GetFileNum(file);
                    else
                    {
                        fileNum++;
                        string ext = Path.GetExtension(file).ToLower();
                        if (pList.ContainsKey(ext) == false)
                            pList.Add(ext, 1);
                        else
                            pList[ext]++;
                    }
                }

            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
        }

        static void Main(string[] args)
        {
            Program p = new Program();
            p.GetFileNum(args[0]); //获取目录路径，第一个命令行参数
            Console.WriteLine("扫描文件数目" + p.fileNum); //扫描文件总数

            foreach (var dic in p.pList)
            {
                Console.WriteLine("{0}  {1}", dic.Key, dic.Value);
            }
        }
    }
}

```
