###  linux-asp.net-installScript

自动安装 auto install Docker | rancher | k8s | mysql | redis | haproxy | mongodb | nginx | Node.js | mosquitto (MQTT server)

###   [WIKI](https://github.com/cjy37/linux-install-script/wiki)

###     1. [Ubuntu v12.04 安装 ](#11-ubuntu1204)
###     2. [Centos v5/v6 安装 ](#12-centos56)
###     3. [Centos v7 安装 ](#13-centos7)
###     4. [Fedora v19/20 安装 ](#14-fedora1920)

###
###     Docker and Rancher install:
###     1. [Centos7 Docker 安装 ](#15-centos7-docker-install)
###     2. [Ubuntu16 Docker 安装 ](#16-ubuntu16-docker-install)

===========================

### 1.1 Ubuntu12.04:
运行linux脚本：
```
cd /tmp
rm -f ubuntu-installScript
wget https://github.com/cjy37/linux-install-script/raw/master/ubuntu-installScript
chmod +x ubuntu-installScript
sudo ./ubuntu-installScript

```
运行界面:
```
--------------------------------------------------------------
|      Ubuntu12.04 Install Helper                            |
|      版权所有 https://github.com/cjy37                     |
--------------------------------------------------------------
|      a. 安装 全部                                          |
|      b. 安装 Web 服务 (linux mono mysql jexus)[c,d]        |
|      c. 安装 Mono & Jexus (Asp.Net Web 服务)               |
|      d. 安装 Mysql (MariaDB-10)                            |
|      e. 安装 Haproxy                                       |
|      f. 安装 Redis                                         |
|      g. 安装 Node.js                                       |
|      h. 安装 MongoDB                                       |
|      i. 安装 Nginx                                         |
|      j. 安装 MQTT 服务                                     |
|      k. *更新 Mono & Jexus                                 |
|      l. *更新 Jexus (Mono Web 服务)                        |
|      x. 退出                                               |
--------------------------------------------------------------
```
<img src="https://raw.githubusercontent.com/cjy37/linux-asp.net-installScript/master/tar/xcx.jpg" width="200">

### 1.2 Centos5/6: 
运行linux脚本：
```
cd /tmp
rm -f centos-installScript
wget https://github.com/cjy37/linux-asp.net-installScript/raw/master/centos-installScript
chmod +x centos-installScript
./centos-installScript

```
运行界面:
```
--------------------------------------------------------------
|      Centos5/6 Install Helper                              |
|      版权所有 https://github.com/cjy37                     |
--------------------------------------------------------------
|      a. 安装 全部                                          |
|      b. 安装 Web 服务 (linux mono mysql jexus)[c,d]        |
|      c. 安装 Mono & Jexus (Asp.Net Web 服务)               |
|      d. 安装 Mysql (MariaDB-10)                            |
|      e. 安装 Haproxy                                       |
|      f. 安装 Redis                                         |
|      g. 安装 Node.js                                       |
|      h. 安装 MongoDB                                       |
|      i. 安装 Nginx                                         |
|      j. 安装 Memcached                                     |
|      k. 安装 CutyCapt                                      |
|      l. 安装 GtkSharp                                      |
|      x. 退出                                               |
--------------------------------------------------------------
```

<img src="https://raw.githubusercontent.com/cjy37/linux-asp.net-installScript/master/tar/zfb.jpg" width="200">

### 1.3 Centos7: 
运行linux脚本：
```
cd /tmp
rm -f centos7-installScript
wget https://github.com/cjy37/linux-asp.net-installScript/raw/master/centos7-installScript
chmod +x centos7-installScript
./centos7-installScript

```
运行界面:
```
--------------------------------------------------------------
|      Centos7 Install Helper                                |
|      版权所有 https://github.com/cjy37                     |
--------------------------------------------------------------
|      a. 安装 全部                                          |
|      b. 安装 Web 服务 (linux mono mysql jexus)[c,d]        |
|      c. 安装 Mono & Jexus (Asp.Net Web 服务)               |
|      d. 安装 Mysql (MariaDB-10)                            |
|      e. 安装 Haproxy                                       |
|      f. 安装 Redis                                         |
|      g. 安装 Node.js                                       |
|      h. 安装 MongoDB                                       |
|      i. 安装 Nginx                                         |
|      j. 安装 Memcached                                     |
|      x. 退出                                               |
--------------------------------------------------------------
```

<img src="https://raw.githubusercontent.com/cjy37/linux-asp.net-installScript/master/tar/wx.jpg" width="200">

### 1.4 Fedora19/20: 
运行linux脚本：
```
cd /tmp
rm -f fedora-installScript
wget https://github.com/cjy37/linux-asp.net-installScript/raw/master/fedora-installScript
chmod +x fedora-installScript
./fedora-installScript

```
运行界面:
```
--------------------------------------------------------------
|      Fedora19/20 Install Helper                            |
|      版权所有 https://github.com/cjy37                     |
--------------------------------------------------------------
|      a. 安装 全部                                          |
|      b. 安装 Web 服务 (linux mono mysql jexus)[c,d]        |
|      c. 安装 Mono & Jexus (Asp.Net Web 服务)               |
|      d. 安装 Mysql (MariaDB-10)                            |
|      e. 安装 Haproxy                                       |
|      f. 安装 Redis                                         |
|      g. 安装 Node.js                                       |
|      h. 安装 MongoDB                                       |
|      i. 安装 Nginx                                         |
|      x. 退出                                               |
--------------------------------------------------------------
```

### 1.5 Centos7 Docker install: 
运行linux脚本：
```
cd /tmp
rm -f centos7-docker-install.sh
wget https://github.com/cjy37/linux-asp.net-installScript/raw/master/centos7-docker-install.sh
chmod +x centos7-docker-install.sh
./centos7-docker-install.sh

```
运行界面:
```
--------------------------------------------------------------
|      Centos7 Install Helper                                |
|      版权所有 https://github.com/cjy37                     |
--------------------------------------------------------------
|      a. 安装 Docker 运行环境                               |
|      b. 安装 Rancher (Docker控制台)                        |
|      # c. 安装 MySQL   服务  (不推荐, 建议Docker方式)      |
|      # d. 安装 MongoDB 服务  (不推荐, 建议Docker方式)      |
|      # e. 安装 MQTT    服务  (不推荐, 建议Docker方式)      |
|      # f. 安装 Redis   服务  (不推荐, 建议Docker方式)      |
|      # g. 安装 Nginx   服务  (不推荐, 建议Docker方式)      |
|      # h. 安装 Haproxy 服务  (不推荐, 建议Docker方式)      |
|      i. 安装 NFS 共享存储                                  |
|      x. 退出                                               |
--------------------------------------------------------------
```



### 1.6 Ubuntu16 Docker install: 
运行linux脚本：
```
cd /tmp
rm -f ubuntu-docker-install.sh
wget https://raw.githubusercontent.com/cjy37/linux-asp.net-installScript/master/ubuntu-docker-install.sh
chmod +x ubuntu-docker-install.sh
./ubuntu-docker-install.sh

```
运行界面:
```
--------------------------------------------------------------
|      Ubuntu16 Install Helper                               |
|      版权所有 https://github.com/cjy37                     |
--------------------------------------------------------------
|      a. 安装 Docker 运行环境                               |
|      b. 安装 Rancher (Docker控制台)                        |
|      # c. 安装 MySQL   服务  (不推荐, 建议Docker方式)      |
|      # d. 安装 MongoDB 服务  (不推荐, 建议Docker方式)      |
|      # e. 安装 MQTT    服务  (不推荐, 建议Docker方式)      |
|      # f. 安装 Redis   服务  (不推荐, 建议Docker方式)      |
|      # g. 安装 Nginx   服务  (不推荐, 建议Docker方式)      |
|      # h. 安装 Haproxy 服务  (不推荐, 建议Docker方式)      |
|      i. 安装 NFS 共享存储                                  |
|      x. 退出                                               |
--------------------------------------------------------------
```

```
cd /tmp
rm -f ubuntu-rancher-docker.sh
wget https://raw.githubusercontent.com/cjy37/linux-asp.net-installScript/master/ubuntu-rancher-docker.sh
chmod +x ubuntu-rancher-docker.sh
./ubuntu-rancher-docker.sh
```
