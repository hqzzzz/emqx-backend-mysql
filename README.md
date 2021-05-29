
# emqx-backend-mysql

*emqx-backend-mysql* 是 *Emqx* 社区版本 固化插件, 本旨为社区版本提供Mysql信息固化方式


## EMQ X
*EMQ X* 是一款完全开源，高度可伸缩，高可用的分布式 MQTT 消息服务器，适用于 IoT、M2M 和移动应用程序，可处理千万级别的并发客户端。

- 新功能的完整列表，请参阅 [EMQ X Release Notes](https://github.com/emqx/emqx/releases)。

## Build

  [Erlang 环境配置](./erlang.md) 

  应尽量避免在**windows** 环境下编译安装

### 编译发布插件

1、clone emqx-rel 项目, 切换到改 release-4.1

``` bash
git clone https://github.com/emqx/emqx-rel.git
cd emqx-rel
git checkout release-4.1
make
```

正常构建成功后，运行 `_build/emqx/rel/emqx/bin/emqx console` 启动 emqx

### 添加自定义插件

2.rebar.config 添加依赖

```erl
{deps,
   [  {emqx_backend_mysql, {git, "https://github.com/hqzzzz/emqx-backend-mysql.git", {branch, "v4.1"}}} ,
   , ....
   ....
   ]
}

```

3.rebar.config 中 relx 段落添加

```erl
{relx,
    [...
    , ...
    , {release, {emqx, git_describe},
       [
         {emqx_backend_mysql, load},
       ]
      }
    ]
}
```
### 加载插件

> ./bin/emqx_ctl plugins load emqx_backend_mysql

或者编辑

data/loaded_plugins

> 添加 {emqx_backend_mysql, true}.


4.编译

> make

打开 `localhost:18083` 的插件栏可以看到 `emqx_backend_mysql` 插件。

### config 配置

File: etc/emqx_backend_mysql.conf

```
# mysql 服务器
mysql.server = 127.0.0.1:3306

# 连接池数量
mysql.pool_size = 8

# mysql 用户名
mysql.username =

# mysql密码
mysql.password = 

# 数据库名
mysql.database = mqtt

# 超时时间（秒）
mysql.query_timeout = 10s

```


### mqtt_client.sql, mqtt_msg.sql
到你的数据库中执行[mqtt_client.sql](./sql/mqtt_client.sql), [mqtt_msg.sql](./sql/mqtt_msg.sql)。



### 使用

此插件会把public发布的消息保存到mysql中，但并不是全部。也可以在业务规则中添加存储类型的资源。

需要在发布消息的参数中 retain 值设置为 true。 这样这条消息才会被保存在mysql中

eg：

```json
{
  "topic": "buildruntopic",
  "payload": "hello,Buidrun",
  "qos": 1,
  "retain": true,
  "client_id": "mqttjs_8b3b4182ae"
}
```



## 构建docker镜像

`emqx-rel` 项目自带构建镜像的功能

``` bash
make emqx-docker-build
```


## MQTT 规范

你可以通过以下链接了解与查阅 MQTT 协议:

[MQTT Version 3.1.1](https://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html)

[MQTT Version 5.0](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cs02/mqtt-v5.0-cs02.html)

[MQTT SN](http://mqtt.org/new/wp-content/uploads/2009/06/MQTT-SN_spec_v1.2.pdf)

## 开源许可

Apache License 2.0, 详见 [LICENSE](./LICENSE)。
