linux-asp.net-installScript
===========================

MONO asp.net mysql redis haproxy install Script

### 1. Download and unzip:
```
cd /tmp
wget https://github.com/cjy37/linux-asp.net-installScript/archive/master.zip
unzip master
cd linux-asp.net-installScript-master/
```


### 1.1 Ubuntu:
```
sudo apt-get install unzip
cd /tmp
wget https://github.com/cjy37/linux-asp.net-installScript/archive/master.zip
unzip master
cd linux-asp.net-installScript-master/
chmod +x ubuntu-installScript
sudo ./ubuntu-installScript
```
View:
--------------------------------------------------------------
|      Ubuntu Install Helper                                 |
|      copyright https://github.com/cjy37                    |
--------------------------------------------------------------
|      a. Install Web Server + MySQL [d,e,g,h,i,j]           |
|      b. Install Web Server   [d,e,g,i,j]                   |
|      c. Install MySQL    [d,h,j]                           |
|      d. Install Libs     [Public Libs]                     |
|      e. Install mono                                       |
|      f. Install Libgdiplus                                 |
|      g. Install jexus v5                                   |
|      h. Install mysql v5.5                                 |
|      i. Install haproxy                                    |
|      j. Install Redis                                      |
|      k. Install Node.js                                    |
|      l. Install MQTT Server                                |
|      m. Install MongoDB                                    |
|      x. Exit                                               |
--------------------------------------------------------------



### 1.2 CentOS: 
```
chmod +x centos-installScript
./centos-installScript
```
![screen shot](https://raw.github.com/cjy37/linux-asp.net-installScript/master/centos-install.png)

### 1.3 Fedora: 
```
chmod +x fedora-installScript
./fedora-installScript
```
![screen shot](https://raw.github.com/cjy37/linux-asp.net-installScript/master/fedora-install.png)
