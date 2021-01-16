Science
=======

V2ray(service)
-----

1. 一键脚本

```shell
bash <(curl -s -L https://git.io/v2ray.sh)
```

2. 如果要自己更改`/etc/vray/config.json`配置

```json
{
  "inbounds": [
    {
      "port": 16823, // 服务器监听端口
      "protocol": "vmess",    // 主传入协议
      "settings": {
        "clients": [
          {
            "id": "b831381d-6324-4d53-ad4f-8cda48b30811",  // 用户 ID，客户端与服务器必须相同
            "alterId": 64
          }
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",  // 主传出协议
      "settings": {}
    }
  ]
}
```


V2ray(Client)
-------------

1. 安装

```shell
# bash <(curl -L -s https://install.direct/go.sh)
curl -LROJ https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh
bash install-release.sh
```

2. 配置`/etc/v2ray/config.json`

```json
{
  "inbounds": [
    {
      "port": 1080, // 监听端口
      "protocol": "socks", // 入口协议为 SOCKS 5
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls"]
      },
      "settings": {
        "auth": "noauth"  //socks的认证设置，noauth 代表不认证，由于 socks 通常在客户端使用，所以这里不认证
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "vmess", // 出口协议
      "settings": {
        "vnext": [
          {
            "address": "serveraddr.com", // 服务器地址，请修改为你自己的服务器 IP 或域名
            "port": 16823,  // 服务器端口
            "users": [
              {
                "id": "b831381d-6324-4d53-ad4f-8cda48b30811",  // 用户 ID，必须与服务器端配置相同
                "alterId": 64 // 此处的值也应当与服务器相同
              }
            ]
          }
        ]
      }
    }
  ]
}
```

3. uuid

```shell
cat /proc/sys/kernel/random/uuid
```

4. 检查

```shell
v2ray --test --config config.json
```

5. 开机启动

```shell
systemctl enable v2ray
```

6. 控制v2ray启动,停止,重启

```shell
systemctl start | stop | restart
```

