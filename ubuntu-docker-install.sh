#!/bin/bash
#------------------------------------------
#      Ubuntu16.04 asp.net InstallScript
#      copyright https://github.com/cjy37
#      email: rocky.cn@foxmail.com
#------------------------------------------
# set -e

showMenu() {
	clear
	echo
	echo "--------------------------------------------------------------"
	echo "|      Ubuntu16.04 Install Helper                            |"
	echo "|      版权所有 https://github.com/cjy37                     |"
	echo "|------------------------------------------------------------|"
	echo "|      a. 安装 Docker 运行环境                               |"
	echo "|      b. 安装 Rancher (Docker控制台)                        |"
	echo "|      c. 安装 OpenSSH7.6                                    |"
	#echo "|      # c. 安装 MySQL   服务  (不推荐, 建议Docker方式)     |"
	#echo "|      # d. 安装 MongoDB 服务  (不推荐, 建议Docker方式)     |"
	#echo "|      # e. 安装 MQTT    服务  (不推荐, 建议Docker方式)     |"
	#echo "|      # f. 安装 Redis   服务  (不推荐, 建议Docker方式)     |"
	#echo "|      # g. 安装 Nginx   服务  (不推荐, 建议Docker方式)     |"
	#echo "|      # h. 安装 Haproxy 服务  (不推荐, 建议Docker方式)     |"
	echo "|      i. 安装 NFS 共享存储                                  |"
	echo "|      x. 退出                                               |"
	echo "--------------------------------------------------------------"
	echo
	
	return 0
}

selectCmd() {
	alias cp='cp'
	showMenu
	echo "请选择要安装的字母序号 [a-x]:"
	read -n 1 M
	echo

	if [ "$M" = "x" ]; then
		exit 1
		
	elif [ "$M" = "a" ]; then
		echo "安装 Docker 运行环境"
		echo "------------------------------------"
		setupDocker
		read -n 1 -p "按 <Enter> 继续..."
		
	elif [ "$M" = "b" ]; then
		echo "安装 Rancher 服务"
		echo "------------------------------------"
		setupRancher
		read -n 1 -p "按 <Enter> 继续..."

	elif [ "$M" = "c" ]; then
		echo "安装 OpenSSH7.6"
		echo "------------------------------------"
		installSshD
		read -n 1 -p "按 <Enter> 继续..."
		
	#elif [ "$M" = "c" ]; then
	#	echo "安装 MySQL 服务"
	#	echo "------------------------------------"
	#	setupMysql
	#	read -n 1 -p "按 <Enter> 继续..."
    #
	#elif [ "$M" = "d" ]; then
	#	echo "安装 MongoDB 服务"
	#	echo "------------------------------------"
	#	setupMongodb
	#	read -n 1 -p "按 <Enter> 继续..."
	#	
	#elif [ "$M" = "e" ]; then
	#	echo "安装 MQTT 服务（Mosquitto）"
	#	echo "------------------------------------"
	#	setupMosquitto
	#	read -n 1 -p "按 <Enter> 继续..."
    #
    #elif [ "$M" = "f" ]; then
	#	echo "安装 Redis 服务"
	#	echo "------------------------------------"
	#	setupRedis
	#	read -n 1 -p "按 <Enter> 继续..."
	#
    #elif [ "$M" = "g" ]; then
	#	echo "安装 Nginx 服务"
	#	echo "------------------------------------"
	#	setupNginx
	#	read -n 1 -p "按 <Enter> 继续..."
    #
	#elif [ "$M" = "h" ]; then
	#	echo "安装 Haproxy 服务"
	#	echo "------------------------------------"
	#	setupHaproxy
	#	read -n 1 -p "按 <Enter> 继续..."
    #
	elif [ "$M" = "i" ]; then
		echo "安装 NFS 共享存储"
		echo "------------------------------------"
		setupNFS
		read -n 1 -p "按 <Enter> 继续..."

	else
		echo "选择错误!"
		read -n 1 -p "按 <Enter> 继续..."
	fi

	selectCmd
	return 0
}

installSshD() {
    echo "install OpenSSH7.6"
    echo "------------------------------------"
    # https://packages.ubuntu.com/bionic/amd64/openssh-server/download
    cat "deb http://cz.archive.ubuntu.com/ubuntu bionic main" >>  /etc/apt/sources.list
    apt update
    rm -rf /var/lib/dpkg/info/*
    apt install openssh-server
}

setupDocker() {
    echo "install Docker"
    echo "------------------------------------"
    sudo rm -rf /var/lib/dpkg/info/*
    
    sudo apt-get update --fix-missing -y && sudo apt-get autoremove -y && sudo apt-get clean && sudo apt-get install -f
    
    #sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

    sudo tee /etc/apt/sources.list <<-'EOF'
deb http://mirrors.163.com/ubuntu/ xenial main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ xenial-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ xenial-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ xenial-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ xenial-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ xenial main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ xenial-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ xenial-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ xenial-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ xenial-backports main restricted universe multiverse
EOF

    sudo tee /etc/security/limits.conf <<-'EOF'
#增加如下内容
root soft nofile 102400
root hard nofile 102400
* soft nofile 102400
* hard nofile 102400
EOF

    sudo tee /etc/sysctl.conf <<-'EOF'
#增加如下内容
net.ipv4.neigh.default.gc_stale_time=120
net.ipv4.conf.all.rp_filter=0
net.ipv4.conf.default.rp_filter=0
net.ipv4.conf.default.arp_announce=2
net.ipv4.conf.all.arp_announce=2
net.ipv4.tcp_max_tw_buckets=5000
net.ipv4.tcp_syncookies=1
net.ipv4.tcp_max_syn_backlog=1024
net.ipv4.tcp_synack_retries=2
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
net.ipv6.conf.lo.disable_ipv6=1
net.ipv4.conf.lo.arp_announce=2
vm.swappiness=10
vm.vfs_cache_pressure=50
vm.overcommit_memory=1
 
net.core.somaxconn = 65535
net.netfilter.nf_conntrack_max = 655350
net.netfilter.nf_conntrack_tcp_timeout_established = 1200

#增加NFS挂载服务并发数
sunrpc.tcp_slot_table_entries = 128

EOF

    #使修改马上生效
    sysctl -p

    # 删除旧的组件
	sudo apt-get update -y
    sudo apt-get remove -y docker docker-engine docker-ce docker.io
    
    # 安装依赖
	sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common

    sudo rm -rf /var/lib/dpkg/info/* /etc/init.d/docker
    # 安装Docker
    curl https://releases.rancher.com/install-docker/17.03.sh | sh
    
    ## step 2: 安装GPG证书
    #curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
    #
    ## Step 3: 写入软件源信息
    #sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
    #
    ## Step 4: 更新并安装 Docker-CE
    #sudo apt-get -y update
    #sudo apt-get -y install docker-ce=17.03.2~ce-0~ubuntu-xenial
    
    sudo mkdir -p /etc/docker
    
    sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://y1q9bgae.mirror.aliyuncs.com"]
}
EOF
    sudo systemctl daemon-reload
    sudo systemctl restart docker
    
	return $?
}

setupRancher() {
	echo "install rancher"
	echo "------------------------------------"
	
	sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server

    cd /tmp/
    wget https://github.com/rancher/cli/releases/download/v0.6.11-rc2/rancher-linux-amd64-v0.6.11-rc2.tar.gz
    tar xzvf rancher-linux-amd64-v0.6.11-rc2.tar.gz
    sudo cp rancher-v0.6.11-rc2/rancher /usr/bin/
    rm -rf rancher-*
    sudo rancher -v

    echo "请修改 ~/.bashrc 中的 RANCHER 前缀变量"
    echo "# export RANCHER_URL=http://127.0.0.1:8080" >> ~/.bashrc
    echo "# export RANCHER_ACCESS_KEY=xxxx" >> ~/.bashrc
    echo "# export RANCHER_SECRET_KEY=zzzz" >> ~/.bashrc
    # echo "alias huake-rancher='rancher --url http://127.0.0.1:8080 --access-key xxxx --secret-key zzzz --env 1a5'" >> ~/.bashrc
    sudo source ~/.bashrc
    sudo rancher ps

    echo "命令行帮助文档 https://rancher.com/docs/rancher/v1.6/zh/cli/commands/"

    # cd /tmp/ && huake-rancher export web && cd web &&  huake-rancher up -p --force-upgrade --batch-size 99 -u -c -d && cd /tmp/ && rm -rf /tmp/web

	return $?
}


setupMysql() {
	echo "安装 mysql"
	echo "------------------------------------"
	
	echo '# MariaDB 10.0 CentOS repository list - created 2014-10-18 16:58 UTC
# http://mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.0/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1' > /etc/yum.repos.d/MariaDB.repo

	sudo apt-get -y install MariaDB-server MariaDB-client MariaDB-devel
	cp /usr/share/mysql/my-innodb-heavy-4G.cnf /etc/my.cnf
	#sudo sed -i 's/# generic configuration options/user = mysql/g' /etc/my.cnf
	sudo sed -i '/\[mysqld\]/a user = mysql' /etc/my.cnf
	chkconfig --level 2345 mysql on
	service mysql start
	
	mysql -V
	echo "------------------------------------"
	echo "Mysql: Please Ender user(root) password"
	read -e PWD
	mysqladmin -uroot password "$PWD"
	return $?
}

setupMongodb() {
	echo "install Mongodb"
	echo "------------------------------------"
	sudo apt-get -y install mongodb mongodb-server
	echo "Install mongodb completed. info:"
	mongod --version
	echo "------------------------------------"
	return $?
}


setupMosquitto() {
	echo "install Mosquitto"
	echo "------------------------------------"
	
	echo '[home_oojah_mqtt]
name=mqtt (CentOS_CentOS-7)
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-7/
gpgcheck=1
gpgkey=http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-7/repodata/repomd.xml.key
enabled=1
' > /etc/yum.repos.d/Mosquitto.repo

	sudo apt-get -y install mosquitto mosquitto-clients libmosquitto1 libmosquitto-devel libmosquittopp1 libmosquittopp-devel python-mosquitto

	mosquitto -h
	echo "------------------------------------"

	return $?
}

setupRedis() {
	echo "install redis"
	echo "------------------------------------"
	sudo apt-get -y install redis
	echo "Install Redis completed. info:"
	redis-server -v
	echo "------------------------------------"
	return $?
}


setupNginx() {

	echo "install nginx"
	echo "------------------------------------"

	echo '[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1' > /etc/yum.repos.d/nginx.repo
	sudo apt-get -y install nginx
	chkconfig --level 2345 nginx on
	service nginx start
	nginx -v
	echo "------------------------------------"
	return $?
}

setupHaproxy() {
	echo "install haproxy"
	echo "------------------------------------"
	sudo apt-get -y install haproxy
	echo "Install haproxy completed. info:"
	haproxy -v
	echo "------------------------------------"
	return $?
}

setupNFS() {
	echo "install nfs"
	echo "------------------------------------"
    sudo rm -rf /var/lib/dpkg/info/* /etc/init.d/docker
	sudo apt-get install -y nfs-kernel-server
    
    sudo mkdir -p cd /wwwroot
    
    echo "启动NFS服务"
    echo "/wwwroot 172.16.7.0/24(rw,sync,all_squash,anonuid=0,anongid=0)" > /etc/exports
    sudo exportfs -rv
    sudo service nfs-kernel-server restart
    
    #查看NFS的运行状态
    sudo nfsstat

    #查看rpc执行信息，可以用于检测rpc运行情况
    sudo rpcinfo

    # 下载配置文件
    echo "下载配置文件"
    cd /wwwroot/
    wget https://github.com/cjy37/linux-asp.net-installScript/raw/master/config.tar.bz2
    tar xjf config.tar.bz2
    cp -rf config/jenkins_home ./
    rm -f config.tar.bz2
    
    echo "====== 后续操作： ======"
    echo "vim /etc/exports"
    echo 'exports文件配置格式:
NFS共享的目录 NFS客户端地址1(参数1,参数2,...) 客户端地址2(参数1,参数2,...)
要用绝对路径，可被nfsnobody读写。
例如：
# /wwwroot 172.16.7.0/24(rw,sync,all_squash)

重启服务：
# sudo service nfs-kernel-server restar
'

	return $?
}

cd /tmp

#read -n 1 -p "按任意键安装Docker组件. 按 [Ctrl + C] 取消安装."

selectCmd
