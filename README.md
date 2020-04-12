# wireguard-vpn-scripts-lite

subspace 太难用，部署还麻烦，还不如用 shell 写一套脚本。

## 1. 生成服务器key

> 需要 root 权限

```
git clone https://github.com/oicu/wireguard-vpn-scripts-lite.git
cp wireguard-vpn-scripts-lite/* /etc/wireguard/
cd /etc/wireguard/
chmod u+x *.sh
./init.sh
```

## 2. 修改服务器IP
```
vi client.tpl
```

修改

Endpoint = 你的服务器公网IP:监听端口

> 端口要和 server.tpl 里的 ListenPort 一致。

## 3. 启动服务
```
./restart.sh
```

## 4. 添加客户端配置

Client1:
```
./addclient.sh myPC 172.16.1.2
```

Client2:
```
./addclient.sh myiPhone 172.16.1.3
```

## 5. 删除客户端配置

> 这里为什么要带 .conf ？因为可以 tab 补全文件名。

```
./delclient.sh myiPhone.conf
```

or

```
./delclient.sh peers/myiPhone.conf
```
