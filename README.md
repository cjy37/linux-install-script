# linux-asp.net-installScript

MONO asp.net mysql redis haproxy install Script

===========================
## [WIKI](https://github.com/cjy37/linux-asp.net-installScript/wiki)

###     1. [Ubuntu install Script](#11-ubuntu)
###     2. [Centos install Script](#12-centos)
###     3. [Fedora install Script](#13-fedora)

### 1. Download and unzip:
```
cd /tmp
wget https://github.com/cjy37/linux-asp.net-installScript/archive/master.zip
unzip master
cd linux-asp.net-installScript-master/
```


### 1.1 Ubuntu:
```
cd /tmp
wget https://github.com/cjy37/linux-asp.net-installScript/raw/master/ubuntu-installScript
chmod +x ubuntu-installScript
sudo ./ubuntu-installScript
```
Function Menu:                                                         
```
a. Install Web Server + MySQL [d,e,g,h,i,j]  
b. Install Web Server   [d,e,g,i,j]          
c. Install MySQL    [d,h,j]                  
d. Install Libs     [Public Libs]            
e. Install Mono (Last releases version)      
f. *Update Jexus v5.5.3 (Mono Web Server)    
g. Install Jexus v5.5.3 (Mono Web Server)    
h. Install Mysql v5.5 (MariaDB)              
i. Install Haproxy                           
j. Install Redis                             
k. Install Node.js                           
l. Install MQTT Server                       
m. Install MongoDB                           
n. Install Nginx                             
x. Exit
```




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

