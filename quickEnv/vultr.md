Setup a New VPS in Vultr
========================

1. Choose "Los Angeles" instance.
2. Install v2ray.
    If you want to install caddy manually, do not choose "websocket+TLS" protocol.
``` shell
bash <(curl -s -L https://git.io/v2ray.sh)
sudo apt-get install ufw
sudo ufw allow <port>
v2ray bbr
```

If you want to deploy your own site on this server:

3. Make sure your domain name can be resolved to the server's IP address
    (Add `a` and `www` records in your "DNS management website".)

4. Install caddy manually.
``` shell
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy
```
5. Config caddy:
 - Edit Caddyfile in `/etc/caddy /Caddyfile`
 - Upload website static file into the folder specified in Caddyfile, default
 is `/usr/share/caddy`
 - `chown -R caddy:caddy /usr/share/caddy`
