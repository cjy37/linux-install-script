#!/bin/sh
#------------------------------------------
#      Centos7 Install Helper
#      copyright https://github.com/cjy37
#      email: rocky.cn@foxmail.com
#------------------------------------------

function showMenu()
{
	clear
	echo
	echo "--------------------------------------------------------------"
	echo "|      Centos7 Install Helper                                |"
	echo "|      版权所有 https://github.com/cjy37                     |"
	echo "--------------------------------------------------------------"
	echo "|      a. 安装 Docker 运行环境                               |"
	echo "|      b. 安装 Rancher (Docker控制台)                        |"
	echo "|      # c. 安装 MySQL   服务  (不推荐, 建议Docker方式)      |"
	echo "|      # d. 安装 MongoDB 服务  (不推荐, 建议Docker方式)      |"
	echo "|      # e. 安装 MQTT    服务  (不推荐, 建议Docker方式)      |"
	echo "|      # f. 安装 Redis   服务  (不推荐, 建议Docker方式)      |"
	echo "|      # g. 安装 Nginx   服务  (不推荐, 建议Docker方式)      |"
	echo "|      # h. 安装 Haproxy 服务  (不推荐, 建议Docker方式)      |"
	echo "|      i. 安装 NFS 共享存储                                  |"
	echo "|      x. 退出                                               |"
	echo "--------------------------------------------------------------"
	echo
	
	return 0
}

function selectCmd()
{
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
		echo "安装 MySQL 服务"
		echo "------------------------------------"
		setupMysql
		read -n 1 -p "按 <Enter> 继续..."

	elif [ "$M" = "d" ]; then
		echo "安装 MongoDB 服务"
		echo "------------------------------------"
		setupMongodb
		read -n 1 -p "按 <Enter> 继续..."
		
	elif [ "$M" = "e" ]; then
		echo "安装 MQTT 服务（Mosquitto）"
		echo "------------------------------------"
		setupMosquitto
		read -n 1 -p "按 <Enter> 继续..."
    
    elif [ "$M" = "f" ]; then
		echo "安装 Redis 服务"
		echo "------------------------------------"
		setupRedis
		read -n 1 -p "按 <Enter> 继续..."
	
    elif [ "$M" = "g" ]; then
		echo "安装 Nginx 服务"
		echo "------------------------------------"
		setupNginx
		read -n 1 -p "按 <Enter> 继续..."
   
	elif [ "$M" = "h" ]; then
		echo "安装 Haproxy 服务"
		echo "------------------------------------"
		setupHaproxy
		read -n 1 -p "按 <Enter> 继续..."

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

function setupDocker()
{

    # 删除旧的组件
	sudo yum remove docker \
        docker-client \
        docker-client-latest \
        docker-common \
        docker-latest \
        docker-latest-logrotate \
        docker-logrotate \
        docker-selinux \
        docker-engine-selinux \
        docker-engine

    # 安装依赖
	sudo yum install -y yum-utils \
        device-mapper-persistent-data \
        lvm2

    # 安装Docker
    curl https://releases.rancher.com/install-docker/17.03.sh | sh
    
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

function setupRancher()
{
	echo "install rancher"
	echo "------------------------------------"
	
	sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server

	return $?
}


function setupMysql()
{
	echo "安装 mysql"
	echo "------------------------------------"
	
	echo '# MariaDB 10.0 CentOS repository list - created 2014-10-18 16:58 UTC
# http://mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.0/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1' > /etc/yum.repos.d/MariaDB.repo

	yum -y install MariaDB-server MariaDB-client MariaDB-devel
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

function setupMongodb()
{
	echo "install Mongodb"
	echo "------------------------------------"
	yum -y install mongodb mongodb-server
	echo "Install mongodb completed. info:"
	mongod --version
	echo "------------------------------------"
	return $?
}


function setupMosquitto()
{
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

	yum -y install mosquitto mosquitto-clients libmosquitto1 libmosquitto-devel libmosquittopp1 libmosquittopp-devel python-mosquitto

	mosquitto -h
	echo "------------------------------------"

	return $?
}

function setupRedis()
{
	echo "install redis"
	echo "------------------------------------"
	yum -y install redis
	echo "Install Redis completed. info:"
	redis-server -v
	echo "------------------------------------"
	return $?
}


function setupNginx()
{

	echo "install nginx"
	echo "------------------------------------"

	echo '[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1' > /etc/yum.repos.d/nginx.repo
	yum -y install nginx
	chkconfig --level 2345 nginx on
	service nginx start
	nginx -v
	echo "------------------------------------"
	return $?
}

function setupHaproxy()
{
	echo "install haproxy"
	echo "------------------------------------"
	yum -y install haproxy
	echo "Install haproxy completed. info:"
	haproxy -v
	echo "------------------------------------"
	return $?
}

function setupNFS()
{
	echo "install nfs"
	echo "------------------------------------"
	yum install -y nfs-utils rpcbind
    echo " 检查rpcbind是否开机启动"
    systemctl list-unit-files | grep rpcbind.service
    systemctl enable rpcbind.service
    echo "启动rpcbind服务"
    systemctl restart rpcbind.service
    echo " 查看rpc"
    netstat -lntup|grep rpcbind
    echo " 查看nfs服务向rpc注册的端口信息"
    rpcinfo -p localhost
    
    echo
    echo " 检查NFS是否开机启动"
    systemctl list-unit-files | grep nfs.service
    systemctl enable nfs.service
    echo "启动NFS服务"
    echo "/wwwroot 172.16.7.0/24(rw,sync,all_squash)" > /etc/exports
    chown -R nfsnobody.nfsnobody /wwwroot
    systemctl restart nfs.service
    exportfs -rv
    echo "====== 后续操作： ======"
    echo "vim /etc/exports"
    echo "exports文件配置格式:\
NFS共享的目录 NFS客户端地址1(参数1,参数2,...) 客户端地址2(参数1,参数2,...)\
要用绝对路径，可被nfsnobody读写。\
例如：\
# /wwwroot 172.16.7.0/24(rw,sync,all_squash)\
"

	return $?
}


function setupOs7Epel()
{
	echo "Install Centos7_64bit EPEL repository"
	sudo rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
	sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
	sudo yum -y install yum-priorities
	
	return $?
}

function setupOs6Epel()
{
	echo "Install Centos6_64bit EPEL repository"
	rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
	rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
	yum -y install yum-priorities
	
	return $?
}

function setupOs5Epel()
{
	echo "Install Centos5_64bit EPEL repository"
	rpm -ivh http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
	rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-5
	yum -y install yum-priorities
	
	return $?
}

function setupFedoraEpel()
{
	vers=`cat /etc/redhat-release | awk -F'release' '{print $2}' | awk -F'.' '{print $1}' | awk -F' ' '{print $1}'`
	if [ "$vers" = "7" ]; then
		setupOs7Epel
	elif [ "$vers" = "6" ]; then
		setupOs6Epel
	elif [ "$vers" = "5" ]; then
		setupOs5Epel
	fi

	sudo yum -y update
	sudo yum -y groupinstall "Development Tools"
	echo "安装Docker..."
	echo "------------------------------------"

	if [ ! -d /wwwroot ]; then
	  mkdir -pv /wwwroot
	fi
    
	return $?
}


cd /tmp

read -n 1 -p "按任意键安装Docker组件. 按 [Ctrl + C] 取消安装."
setupFedoraEpel
selectCmd
