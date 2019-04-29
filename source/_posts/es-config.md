---
title: Elasticsearch配置文件详解
date: 2019-2-19 14:16:23
categories:
- 技术人生
tags:
- Elasticsearch
---

Elasticsearch的配置文件位于/es-path/conf/elasticsearch.yml，本文基于elasticsearch 6.x版本对配置文件进行详细说明。
对于未提及的配置参数可查阅 https://www.elastic.co/guide/en/elasticsearch/reference/current/modules.html

<!-- more -->

```
# ======================== Elasticsearch Configuration =========================
#
# NOTE: Elasticsearch comes with reasonable defaults for most settings.
#       Before you set out to tweak and tune the configuration, make sure you
#       understand what are you trying to accomplish and the consequences.
#
# The primary way of configuring a node is via this file. This template lists
# the most important settings you may want to configure for a production cluster.
#
# Please consult the documentation for further information on configuration options:
# https://www.elastic.co/guide/en/elasticsearch/reference/index.html
#
# ---------------------------------- Cluster -----------------------------------
#
# Use a descriptive name for your cluster:
# 配置es的集群名称，默认为elasticsearch。es会自动发现在同一网段下的es集群，如果在同一网段下有多个集群，可以用此属性来区分不同的集群。
cluster.name: elasticsearch
#
# ------------------------------------ Node ------------------------------------
#
# Use a descriptive name for the node:
# 节点名称
node.name: node-master
#
# 指定该节点是否有资格被选举成为master，默认是true，es默认集群中的第一台机器为master，如果这台机器宕机就会重新选举master。
node.master: true
#
# 指定该节点是否存储索引数据，默认为true。
node.data: true
#
# 默认情况下，多个节点可以在同一个安装路径启动，如果想让es只启动一个节点，可以进行如下设置
# node.max_local_storage_nodes: 1
#
# Add custom attributes to the node:
#
# 指定节点的部落属性，这是一个比集群更大的范围。
#node.attr.rack: r1
#
# ----------------------------------- Index ------------------------------------
# 设置索引的分片数,默认为5
#index.number_of_shards: 5

# 设置索引的副本数,默认为1:
#index.number_of_replicas: 1

# 配置文件中提到的最佳实践是,如果服务器够多,可以将分片提高,尽量将数据平均分布到大集群中去
# 同时,如果增加副本数量可以有效的提高搜索性能
# 需要注意的是,"number_of_shards" 是索引创建后一次生成的,后续不可更改设置
# "number_of_replicas" 是可以通过API去实时修改设置的

# ----------------------------------- Paths ------------------------------------
#
# Path to directory where to store the data (separate multiple locations by comma):
# 设置索引数据的存储路径，默认是es根目录下的data文件夹，可以设置多个存储路径，用逗号隔开，如 path.data: /path/to/data1,/path/to/data2
#path.data: /path/to/data
#
# Path to conf files:
# 设置配置文件的存储路径，默认是es根目录下的config文件夹。
#path.conf: /path/to/conf
#
# Path to log files:
# 设置日志文件的存储路径，默认是es根目录下的logs文件夹。
#path.logs: /path/to/logs
#
# Path to temp files:
# 设置临时文件的存储路径，默认是es根目录下的work文件夹。
#path.work: /path/to/work
#
# Path to plugin files:
# 设置插件的存放路径，默认是es根目录下的plugins文件夹。
#path.plugins: /path/to/plugins
#
# ----------------------------------- Memory -----------------------------------
#
# Lock the memory on startup:
# 设置为true来锁住内存。因为当jvm开始swapping时es的效率会降低，所以要保证它不swap。
# 可以把ES_MIN_MEM和ES_MAX_MEM两个环境变量设置成同一个值，并且保证机器有足够的内存分配给es。
# 同时也要允许elasticsearch的进程可以锁住内存，linux下可以通过`ulimit -l unlimited`命令。
#bootstrap.memory_lock: true
#
# Make sure that the heap size is set to about half the memory available
# on the system and that the owner of the process is allowed to use this
# limit.
#
# Elasticsearch performs poorly when the system is swapping the memory.
#
# Cache部分:
# es有很多种方式来缓存其内部与索引有关的数据.其中包括filter cache

# filter cache部分:
# filter cache是用来缓存filters的结果的.默认的cache type是node type.
# node type的机制是所有的索引内部的分片共享filter cache.node type采用的方式是LRU方式.
# 即:当缓存达到了某个临界值之后，es会将最近没有使用的数据清除出filter cache.使让新的数据进入es.

# 这个临界值的设置方法如下：indices.cache.filter.size 值类型：eg.:512mb 20%。默认的值是10%。

# out of memory错误避免过于频繁的查询时集群假死
# 1.设置es的缓存类型为Soft Reference,它的主要特点是据有较强的引用功能.
# 只有当内存不够的时候,才进行回收这类内存,因此在内存足够的时候,它们通常不被回收.
# 另外,这些引用对象还能保证在Java抛出OutOfMemory异常之前,被设置为null.
# 它可以用于实现一些常用图片的缓存,实现Cache的功能,保证最大限度的使用内存而不引起OutOfMemory.
# 在es的配置文件加上index.cache.field.type: soft即可.

# 2.设置es最大缓存数据条数和缓存失效时间,通过设置index.cache.field.max_size: 50000把缓存field的最大值设置为50000,
# 设置index.cache.field.expire: 10m把过期时间设置成10分钟.
# index.cache.field.max_size: 50000
# index.cache.field.expire: 10m
# index.cache.field.type: soft

# field data部分&&circuit breaker部分：
# 用于fielddata缓存的内存数量,主要用于当使用排序,faceting操作时,elasticsearch会将一些热点数据加载到内存中来提供给客户端访问,
# 但是这种缓存是比较珍贵的,所以对它进行合理的设置.

# 可以使用值：eg:50mb 或者 30％(节点 node heap内存量),默认是：unbounded #indices.fielddata.cache.size： unbounded
# field的超时时间.默认是-1,可以设置的值类型: 5m #indices.fielddata.cache.expire: -1

# circuit breaker部分:
# 断路器是elasticsearch为了防止内存溢出的一种操作,每一种circuit breaker都可以指定一个内存界限触发此操作,
# 这种circuit breaker的设定有一个最高级别的设定:indices.breaker.total.limit 默认值是JVM heap的70%.
# 当内存达到这个数量的时候会触发内存回收。

# 另外还有两组子设置：
#indices.breaker.fielddata.limit:当系统发现fielddata的数量达到一定数量时会触发内存回收.默认值是JVM heap的70%
#indices.breaker.fielddata.overhead:在系统要加载fielddata时会预估,发现要加载进内存的值超过limit * overhead时会进行进行内存回收.默认是1.03
#indices.breaker.request.limit:这种断路器是elasticsearch为了防止OOM(内存溢出),在每次请求数据时设定了一个固定的内存数量.默认值是40%
#indices.breaker.request.overhead:同上,也是elasticsearch在发送请求时设定的一个预估系数,用来防止内存溢出.默认值是1

# Translog部分:
# 每一个分片(shard)都有一个transaction log或者是与它有关的预写日志,(write log),
# 在es进行索引(index)或者删除(delete)操作时会将没有提交的数据记录在translog之中,
# 当进行flush 操作的时候会将tranlog中的数据发送给Lucene进行相关的操作.一次flush操作的发生基于如下的几个配置
#index.translog.flush_threshold_ops:当发生多少次操作时进行一次flush.默认是 unlimited #index.translog.
#flush_threshold_size:当translog的大小达到此值时会进行一次flush操作.默认是512mb
#index.translog.flush_threshold_period:在指定的时间间隔内如果没有进行flush操作,会进行一次强制flush操作.默认是30m
#index.translog.interval:多少时间间隔内会检查一次translog,来进行一次flush操作.es会随机的在这个值到这个值的2倍大小之间进行一次操作,默认是5s
#index.gateway.local.sync:多少时间进行一次的写磁盘操作,默认是5s
# 以上的translog配置都可以通过API进行动态的设置
#
# ---------------------------------- Network -----------------------------------
#
# Set the bind address to a specific IP (IPv4 or IPv6):
# 设置本机器绑定的监听ip地址，默认为0.0.0.0。
network.host: 127.0.0.1
#
# Set a custom port for HTTP:
# 设置对外服务的http端口，默认为9200。
http.port: 9200
#
# 设置内容的最大容量，默认100mb
# http.max_content_length: 100mb
#
# 是否使用http协议对外提供服务，默认为true，开启。
# http.enabled: false
#
# 设置节点间交互的tcp端口，默认是9300。
transport.tcp.port: 9300
#
# 设置是否压缩tcp传输时的数据，默认为false，不压缩。
# transport.tcp.compress: false
#
# For more information, consult the network module documentation.
#
# --------------------------------- Discovery ----------------------------------
#
# Pass an initial list of hosts to perform discovery when new node is started:
# The default list of hosts is ["127.0.0.1", "[::1]"]
# 设置集群中master节点的初始列表，可以通过这些节点来自动发现新加入集群的节点，默认的通讯端口是9300。
discovery.zen.ping.unicast.hosts: ["host1", "host2:port", "host3[portX-portY]"]
#
# Prevent the "split brain" by configuring the majority of nodes (total number of master-eligible nodes / 2 + 1):
# 设置这个参数来保证集群中的节点可以知道其它N个有master资格的节点。默认为1，对于大的集群来说，可以设置大一点的值（2-4）
#discovery.zen.minimum_master_nodes: 1
#
# 设置集群中自动发现其它节点时ping连接超时时间，默认为3秒，对于比较差的网络环境可以高点的值来防止自动发现时出错(脑裂)。
#discovery.zen.ping.timeout: 3s
#
# 设置是否打开多播发现节点，默认是true。当多播不可用或者集群跨网段的时候集群通信建议用单播。
# discovery.zen.ping.multicast.enabled: false
#
# For more information, consult the zen discovery module documentation.
#
# ---------------------------------- Gateway -----------------------------------
#
# Block initial recovery after a full cluster restart until N nodes are started:
# 设置集群中N个节点启动时进行数据恢复，默认为3。
#gateway.recover_after_nodes: 3
#
# gateway的类型，默认为local即为本地文件系统，可以设置为本地文件系统，分布式文件系统，hadoop的HDFS，和amazon的s3服务器等
#gateway.type: local
#
# 设置初始化数据恢复进程的超时时间，超时时间从上一个配置中配置的N个节点启动后算起，默认是5分钟。
#gateway.recover_after_time: 5m
#
# 设置这个集群中节点的数量，默认为2，一旦这N个节点启动，就会立即进行数据恢复。
#gateway.expected_nodes: 2
#
# For more information, consult the gateway module documentation.
#
# ---------------------------- Recovery Throttling -----------------------------
#
# 下面这些配置允许在初始化恢复,副本分配,再平衡,或者添加和删除节点时控制节点间的分片分配
# 设置一个节点的并行恢复数
# 1.初始化数据恢复时,并发恢复线程的个数,默认为4
# cluster.routing.allocation.node_initial_primaries_recoveries: 4

# 2.添加删除节点或负载均衡时并发恢复线程的个数,默认为2
# cluster.routing.allocation.node_concurrent_recoveries: 2

# 设置恢复时的吞吐量(例如:100mb,默认为0无限制.如果机器还有其他业务在跑的话还是限制一下的好)
# indices.recovery.max_bytes_per_sec: 20mb

# 设置来限制从其它分片恢复数据时最大同时打开并发流的个数,默认为5
# indices.recovery.concurrent_streams: 5
# 注意: 合理的设置以上参数能有效的提高集群节点的数据恢复以及初始化速度
#
# ---------------------------------- Various -----------------------------------
#
# Require explicit names when deleting indices:
#
#action.destructive_requires_name: true
# 如果启用了 HTTP 端口，开启跨域访问支持，默认为false
http.cors.enabled: true
# 如果 http.cors.enabled 的值为 true，那么该属性会指定访问允许的域名地址，(允许所有域名)以上使用正则
http.cors.allow-origin: /.*/

```
## 参考
- http://www.cnblogs.com/xiaochina/p/6855591.html
- https://www.cnblogs.com/sunxucool/p/3799190.html
