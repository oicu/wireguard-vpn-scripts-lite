# wireguard-vpn-scripts-lite

subspace 太难用，部署还麻烦，还不如用 shell 写一套脚本。

这个是简化版，去掉了 <del>从地址池自动分配IP</del>、iptables nat设置、允许访问内网IP段、<del>生成客户端配置的二维码图片、把二维码</del>和clients/xxx.conf给用户发邮件 等功能。

默认使用网段 `172.16.0.0/24`，如果需要更多的客户端IP地址，可修改 `init.sh` `wg-users.sh` `client.tpl` 里的IP地址池及掩码。

## 0. 安装依赖

为了方便手机客户端使用，把配置文件转二维码及图片。

Debian/Ubuntu
```
apt-get install qrencode
```

CentOS/RHEL
```
yum install qrencode
```

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

> 从地址池自动分配IP地址，生成配置后，终端同时显示配置的二维码，便于手机的 WireGuard 客户端扫描。

Client1:
```
./addclient.sh myPC
```

Client2:
```
./addclient.sh myiPhone
```

## 5. 分发客户端配置
```
cat clients/myiPhone.conf
```

如果你安装了`qrencode`，也可以这样生成二维码，然后直接用手机的 WireGuard 客户端扫描：
```
qrencode -t ansiutf8 < clients/myiPhone.conf
```

## 6. 删除客户端配置

> 这里为什么要带 .conf ？因为可以 tab 补全文件名。

```
./delclient.sh myiPhone.conf
```

or

```
./delclient.sh peers/myiPhone.conf
```

## 7. 查看用户列表

扩展一下 `wg` 命令，方便查看用户配置及对应的 IP 地址。


只显示配置名和IP地址：

```
./wg-users.sh
```


显示详细链接信息：

```
./wg-users.sh -v
```
