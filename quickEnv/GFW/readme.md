Science surfing
=======

V2ray(service)
-----

1. 一键脚本

```shell
bash <(curl -s -L https://git.io/v2ray.sh)
```
[详细教程](https://github.com/233boy/v2ray/wiki/V2Ray%E6%90%AD%E5%BB%BA%E8%AF%A6%E7%BB%86%E5%9B%BE%E6%96%87%E6%95%99%E7%A8%8B)

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

1. [安装](https://github.com/v2fly/fhs-install-v2ray)

```shell
# install v2ray
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)
# remove v2ray
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh) --remove
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

Issues
------
1. check firewall setting in VPS.
2. check firewall setting in operating system.
  - Ubuntu
  ``` shell
  sudo apt-get install ufw
  sudo ufw enable
  sudo ufw allow <port>
  sudo ufw allow <port>/<optional: protocal>
  sudo ufw deny <port>/<optional: protocol>

  # e.g.
  sudo ufw status
  sudo ufw allow 22/tcp
  sudo ufw allow http
  sudo ufw allow from 69.171.224.37/16 port 80,443 proto tcp
  sudo ufw allow from 192.168.0.1 to any port 22
  sudo ufw status numbered
  sudo ufw delete 5
  sudo ufw reset
  ```
  > Ufw stands for Uncomplicated Firewall.
  
3. Caddy
  - change ownership of caddy static file
    ``` shell
    chown -R caddy:caddy /usr/share/caddy
    ```
