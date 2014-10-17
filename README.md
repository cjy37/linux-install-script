###  linux-asp.net-installScript

Auto install MONO (asp.net linux runtime) | Jexus (asp.net linux server) | mysql | redis | haproxy | mongodb | nginx | Node.js | mosquitto (MQTT server)

###   [WIKI](https://github.com/cjy37/linux-asp.net-installScript/wiki)

###     1. [Ubuntu v12.04 install ](#11-ubuntu1204)
###     2. [Centos v5/v6 install ](#12-centos56)
###     3. [Centos v7 install ](#13-centos7)
###     4. [Fedora v19/20 install ](#14-fedora1920)

===========================

### 1.1 Ubuntu12.04:
```
cd /tmp
rm -f ubuntu-installScript
wget https://github.com/cjy37/linux-asp.net-installScript/raw/master/ubuntu-installScript
chmod +x ubuntu-installScript
sudo ./ubuntu-installScript

```
Running interface:
```
--------------------------------------------------------------
|      Ubuntu12.04 Install Helper                            |
|      copyright https://github.com/cjy37                    |
--------------------------------------------------------------
|      a. Install Web Server + MySQL [d,e,g,h,i,j]           |
|      b. Install Web Server   [d,e,g,i,j]                   |
|      c. Install MySQL    [d,h,j]                           |
|      d. Install Libs     [Public Libs]                     |
|      e. Install Mono (Last releases version)               |
|      f. *Update Jexus v5.5.3 (Mono Web Server)             |
|      g. Install Jexus v5.5.3 (Mono Web Server)             |
|      h. Install Mysql v5.5 (MariaDB)                       |
|      i. Install Haproxy                                    |
|      j. Install Redis                                      |
|      k. Install Node.js                                    |
|      l. Install MQTT Server                                |
|      m. Install MongoDB                                    |
|      n. Install Nginx                                      |
|      o. *Update Mono (After v3.6.0)                        |
|      x. Exit                                               |
--------------------------------------------------------------
```


### 1.2 Centos5/6: 
```
cd /tmp
rm -f centos-installScript
wget https://github.com/cjy37/linux-asp.net-installScript/raw/master/centos-installScript
chmod +x centos-installScript
./centos-installScript

```
Running interface:
```
--------------------------------------------------------------
|      Centos6 Install Helper                                |
|      copyright https://github.com/cjy37                    |
--------------------------------------------------------------
|      a. Install Web Server + MySQL [d,e,g,h,k,l]           |
|      b. Install Web Server   [d,e,g,k,l]                   |
|      c. Install MySQL    [d,h,l]                           |
|      d. Install Libs     [Public Libs]                     |
|      e. Install mono                                       |
|      g. Install jexus v5                                   |
|      h. Install mysql v5.5                                 |
|      i. Install memcached                                  |
|      j. Install nginx                                      |
|      k. Install haproxy                                    |
|      l. Install Redis                                      |
|      m. Install CutyCapt                                   |
|      n. Install GtkSharp                                   |
|      x. Exit                                               |
--------------------------------------------------------------
```

### 1.3 Centos7: 
```
cd /tmp
rm -f centos7-installScript
wget https://github.com/cjy37/linux-asp.net-installScript/raw/master/centos7-installScript
chmod +x centos7-installScript
./centos7-installScript

```
Running interface:
```
--------------------------------------------------------------
|      Centos7 Install Helper                                |
|      copyright https://github.com/cjy37                    |
--------------------------------------------------------------
|      a. Install Web Server + MySQL [d,e,g,h,k,l]           |
|      b. Install Web Server   [d,e,g,k,l]                   |
|      c. Install MySQL    [d,h,l]                           |
|      d. Install Libs     [Public Libs]                     |
|      e. Install mono                                       |
|      f. Install Nodejs                                     |
|      g. Install jexus v5                                   |
|      h. Install mysql v5.5                                 |
|      i. Install memcached                                  |
|      j. Install nginx                                      |
|      k. Install haproxy                                    |
|      l. Install Redis                                      |
|      m. Install CutyCapt                                   |
|      n. Install GtkSharp                                   |
|      o. Install MongoDB                                    |
|      x. Exit                                               |
--------------------------------------------------------------
```

### 1.4 Fedora19/20: 
```
cd /tmp
rm -f fedora-installScript
wget https://github.com/cjy37/linux-asp.net-installScript/raw/master/fedora-installScript
chmod +x fedora-installScript
./fedora-installScript

```
Running interface:
```
--------------------------------------------------------------
|      Fedora19/20 Install Helper                            |
|      copyright https://github.com/cjy37                    |
--------------------------------------------------------------
|      a. Install Web Server + MySQL [d,e,g,h,k,l]           |
|      b. Install Web Server   [d,e,g,k,l]                   |
|      c. Install MySQL    [d,h,l]                           |
|      d. Install Libs     [Public Libs]                     |
|      e. Install mono                                       |
|      g. Install jexus v5                                   |
|      h. Install mysql v5.5                                 |
|      j. Install nginx                                      |
|      k. Install haproxy                                    |
|      l. Install Redis                                      |
|      x. Exit                                               |
--------------------------------------------------------------
```

