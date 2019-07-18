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
	echo "|      d. 安装 NFS 共享存储                                  |"
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
	
	elif [ "$M" = "d" ]; then
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
    sudo tee /etc/apt/sources.list <<-'EOF'
deb http://cz.archive.ubuntu.com/ubuntu bionic main
EOF
    sudo apt-get update -y
    sudo rm -rf /var/lib/dpkg/info/*
    sudo apt-get install openssh-server -y
}

setupDocker() {
    echo "install Docker"
    echo "------------------------------------"
    sudo rm -rf /var/lib/dpkg/info/*
    
    echo "信任服务器# sudo ufw allow from 222.25.2.168"
    # 基础端口
    sudo ufw allow 22
    sudo ufw allow 80
    
    # Rancher基础端口
    sudo ufw allow 8080
    sudo ufw allow 500
    sudo ufw allow 4500
    sudo ufw allow 4789
    
    # 服务基础端口
    sudo ufw allow 9200
    sudo ufw allow 3000
    sudo ufw allow 9400
    
    # 数据库基础端口
    sudo ufw allow 6379
    sudo ufw allow 1883
    sudo ufw allow 27017
    sudo ufw allow 3306
    
    sudo apt-get update --fix-missing -y && sudo apt-get autoremove -y && sudo apt-get clean && sudo apt-get install -f
    
    #sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo chmod -R 1777 /tmp
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

net.core.somaxconn=65535
net.netfilter.nf_conntrack_max=655350
net.netfilter.nf_conntrack_tcp_timeout_established=1200

#增加NFS挂载服务并发数
sunrpc.tcp_slot_table_entries=128

EOF

    #使修改马上生效
    sudo sysctl -p

    # 删除旧的组件
	sudo apt-get update -y
    sudo apt-get remove -y docker docker-engine docker-ce docker.io
    
    # 安装依赖
	sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common

    sudo rm -rf /var/lib/dpkg/info/* /etc/init.d/docker /etc/default/docker
    # 安装Docker
    curl https://releases.rancher.com/install-docker/17.03.sh | sh
    
    curl https://raw.githubusercontent.com/moby/moby/master/contrib/check-config.sh | sudo sh
    
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

# ====== 安装 Docker ======
setupDocker2() {
	echo "install Docker"
	echo "------------------------------------"
	echo "配置每台主机的hosts(/etc/hosts),添加host_ip $hostname到/etc/hosts文件中。"
	
	# Rancher基础端口
	sudo ufw allow 80
	sudo ufw allow 443
	sudo ufw allow 22
	sudo ufw allow 2376
	sudo ufw allow 2379
	sudo ufw allow 2380
	sudo ufw allow 6443
	sudo ufw allow 8080
	sudo ufw allow 8472
	sudo ufw allow 10250
	sudo ufw allow 10254
	sudo ufw allow 9099
	# ufw disable ?
	
	# 修改时区
	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	
	# 修改系统语言环境
	sudo echo 'LANG="en_US.UTF-8"' >> /etc/profile;source /etc/profile
	
	# Kernel性能调优
	cat >> /etc/sysctl.conf<<EOF
net.ipv4.ip_forward=1
net.bridge.bridge-nf-call-iptables=1
net.ipv4.neigh.default.gc_thresh1=4096
net.ipv4.neigh.default.gc_thresh2=6144
net.ipv4.neigh.default.gc_thresh3=8192

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

net.core.somaxconn=65535
net.netfilter.nf_conntrack_max=655350
net.netfilter.nf_conntrack_tcp_timeout_established=1200

#增加NFS挂载服务并发数
sunrpc.tcp_slot_table_entries=128

EOF

	# 保存配置
	sysctl -p

	modprobe br_netfilter
	modprobe ip6_udp_tunnel
	modprobe ip_set
	modprobe ip_set_hash_ip
	modprobe ip_set_hash_net
	modprobe iptable_filter
	modprobe iptable_nat
	modprobe iptable_mangle
	modprobe iptable_raw
	modprobe nf_conntrack_netlink
	modprobe nf_conntrack
	modprobe nf_conntrack_ipv4
	modprobe nf_defrag_ipv4
	modprobe nf_nat
	modprobe nf_nat_ipv4
	modprobe nf_nat_masquerade_ipv4
	modprobe nfnetlink
	modprobe udp_tunnel
	modprobe VETH
	modprobe VXLAN
	modprobe x_tables
	modprobe xt_addrtype
	modprobe xt_conntrack
	modprobe xt_comment
	modprobe xt_mark
	modprobe xt_multiport
	modprobe xt_nat
	modprobe xt_recent
	modprobe xt_set
	modprobe xt_statistic
	modprobe xt_tcpudp
	
	# 修改系统源
	sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
cat > /etc/apt/sources.list << EOF

deb http://mirrors.aliyun.com/ubuntu/ xenial main
deb-src http://mirrors.aliyun.com/ubuntu/ xenial main
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main
deb http://mirrors.aliyun.com/ubuntu/ xenial universe
deb-src http://mirrors.aliyun.com/ubuntu/ xenial universe
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates universe
deb http://mirrors.aliyun.com/ubuntu/ xenial-security main
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main
deb http://mirrors.aliyun.com/ubuntu/ xenial-security universe
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security universe

EOF

	# 定义安装版本
	export docker_version=17.03.2
	# step 1: 安装必要的一些系统工具
	sudo apt update
	sudo apt -y install apt-transport-https ca-certificates curl software-properties-common bash-completion
	# step 2: 安装GPG证书
	sudo curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
	# Step 3: 写入软件源信息
	sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
	# Step 4: 更新并安装 Docker-CE
	sudo apt -y update
	version=$(apt-cache madison docker-ce|grep ${docker_version}|awk '{print $3}')
	# --allow-downgrades 允许降级安装
	sudo apt -y install docker-ce=${version} --allow-downgrades
	# 设置开机启动
	sudo systemctl enable docker
	sudo usermod -aG docker dereck
	
	cat > /etc/docker/daemon.json << EOF
{
	"registry-mirrors": ["https://7bezldxe.mirror.aliyuncs.com/"],
	"insecure-registries": ["docker.yingzi.com:52375"],
	"storage-driver": "overlay2",
	"storage-opts": ["overlay2.override_kernel_check=true"],
	"log-driver": "json-file",
	"log-opts": {
		"max-size": "100m",
		"max-file": "3"
	}
}
EOF
	# 重启服务
	sudo systemctl restart docker
	
	# Ubuntu\Debian系统下，默认cgroups未开启swap account功能，这样会导致设置容器内存或者swap资源限制不生效。可以通过以下命令解决
	sudo sed -i 's/GRUB_CMDLINE_LINUX="/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1  /g'  /etc/default/grub
	sudo update-grub
	
	cd /data
	wget https://github.com/rancher/rke/releases/download/v0.1.15/rke_linux-amd64
	chmod +x rke_linux-amd64
	./rke_linux-amd64 --version
	mv rke_linux-amd64 rke
	sudo ln -sf /data/rke /usr/bin/rke
	
	sudo apt update && sudo apt install -y apt-transport-https
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	sudo touch /etc/apt/sources.list.d/kubernetes.list
	echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt update
	sudo apt install -y kubectl
	
}

# ========= 安装 Rancher2 ==========
setupRancher2() {
	cat > /data/config/nginx/nginx.conf << EOF
worker_processes 4;
worker_rlimit_nofile 40000;

events {
    worker_connections 8192;
}

http {
    server {
        listen         80;
        return 301 https://$host$request_uri;
    }
}

stream {
    upstream rancher_servers {
        least_conn;
        server 172.20.200.13:443 max_fails=3 fail_timeout=5s;
        server 172.20.200.14:443 max_fails=3 fail_timeout=5s;
        server 172.20.200.15:443 max_fails=3 fail_timeout=5s;
    }
    server {
        listen     443;
        proxy_pass rancher_servers;
    }
}
EOF

	docker run -d --restart=unless-stopped \
	  -p 80:80 -p 443:443 \
	  -v /data/config/nginx/nginx.conf:/etc/nginx/nginx.conf \
	  nginx:1.14
  
	cat > /data/config/rancher/rancher-cluster.yml << EOF
nodes:
  - address: 172.20.200.13
    # internal_address: 172.16.22.12
    user: dereck
    role: [controlplane,worker,etcd]
  - address: 172.20.200.14
    # internal_address: 172.16.32.37
    user: dereck
    role: [controlplane,worker,etcd]
  - address: 172.20.200.15
    # internal_address: 172.16.42.73
    user: dereck
    role: [controlplane,worker,etcd]

services:
  etcd:
    snapshot: true
    creation: 6h
    retention: 24h
EOF

	# 运行RKE命令
	cd /data
	rke up --config /data/config/rancher/rancher-cluster.yml
	export KUBECONFIG=$(pwd)/kube_config_rancher-cluster.yml
	sudo echo 'KUBECONFIG=$(pwd)/kube_config_rancher-cluster.yml' >> /etc/profile; source /etc/profile

	kubectl -n kube-system create serviceaccount tiller
	kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller

	cd /data
	wget https://storage.googleapis.com/kubernetes-helm/helm-v2.12.1-linux-amd64.tar.gz
	https://storage.googleapis.com/kubernetes-helm/helm-v2.12.1-linux-amd64.tar.gz
	sudo mv linux-amd64/helm /usr/bin/helm
	
	# install helm server
	helm init --service-account tiller   --tiller-image registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.11.0 --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts

	helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
	helm install stable/cert-manager \
	  --name cert-manager \
	  --namespace kube-system
	  
	helm install rancher-stable/rancher \
	  --name rancher \
	  --namespace cattle-system \
	  --set hostname=rancher.abc.com \
	  --set ingress.tls.source=letsEncrypt \
	  --set letsEncrypt.email=chenjingyuan@abc.com
}

setupRancher() {
	echo "install rancher"
	echo "------------------------------------"
	echo '容器启动不了的解决方案：
https://stackoverflow.com/questions/43925524/docker-image-fails-to-create-netlink-handle 
sudo service  ds_agent stop
sudo ufw disable
可能还需要重启'
    sudo systemctl disable ds_agent.service
    sudo service  ds_agent stop
    
    sudo mkdir -p /wwwroot/rancher_db
	
    sudo docker run -d --restart=unless-stopped -p 8080:8080 -v /wwwroot/rancher_db:/var/lib/mysql rancher/server

    cd /tmp/
    wget https://github.com/rancher/cli/releases/download/v0.6.11-rc2/rancher-linux-amd64-v0.6.11-rc2.tar.gz
    sudo tar xzvf rancher-linux-amd64-v0.6.11-rc2.tar.gz
    sudo cp rancher-v0.6.11-rc2/rancher /usr/bin/
    sudo rm -rf rancher-*
    sudo rancher -v

    # echo "请修改 ~/.bashrc 中的 RANCHER 前缀变量"
    echo "请自行修改 ~/.bashrc 中，RANCHER_前缀的值，再执行# source ~/.bashrc"
    echo "" >> ~/.bashrc
    echo "RANCHER 变量" >> ~/.bashrc
    echo "# export RANCHER_URL=http://127.0.0.1:8080" >> ~/.bashrc
    echo "# export RANCHER_ACCESS_KEY=xxxx" >> ~/.bashrc
    echo "# export RANCHER_SECRET_KEY=zzzz" >> ~/.bashrc
    
    #sudo source ~/.bashrc
    #sudo rancher ps

    echo "命令行帮助文档 https://rancher.com/docs/rancher/v1.6/zh/cli/commands/"

    # cd /tmp/ && huake-rancher export web && cd web &&  huake-rancher up -p --force-upgrade --batch-size 99 -u -c -d && cd /tmp/ && rm -rf /tmp/web

	return $?
}

setupNFS() {
	echo "install nfs"
	echo "------------------------------------"
    sudo rm -rf /var/lib/dpkg/info/*
	sudo apt-get install -y nfs-kernel-server
    
    sudo mkdir -p cd /wwwroot
    
    echo "启动NFS服务"
    sudo tee /etc/exports <<-'EOF'
/wwwroot 172.16.7.0/24(rw,sync,all_squash,anonuid=0,anongid=0)
EOF
    sudo exportfs -rv
    sudo service nfs-kernel-server restart
    
    # NFS服务端口
    sudo ufw allow 111
    sudo ufw allow 2049
    sudo ufw allow 1001
    
    # NFS服务端口2
    sudo ufw allow 32803
    sudo ufw allow 32769
    sudo ufw allow 892
    sudo ufw allow 662
    
    #查看NFS的运行状态
    sudo nfsstat

    #查看rpc执行信息，可以用于检测rpc运行情况
    sudo rpcinfo

    # 下载配置文件
    #echo "下载配置文件"
    #cd /wwwroot/
    #wget https://github.com/cjy37/linux-asp.net-installScript/raw/master/config.tar.bz2
    #tar xjf config.tar.bz2
    #cp -rf config/jenkins_home ./
    #rm -f config.tar.bz2
    
    echo "====== 后续操作： ======"
    echo "vim /etc/exports"
    echo 'exports文件配置格式:
NFS共享的目录 NFS客户端地址1(参数1,参数2,...) 客户端地址2(参数1,参数2,...)
要用绝对路径，可被nfsnobody读写。
例如：
# /wwwroot 172.16.7.0/24(rw,sync,all_squash)

重启服务：
# sudo service nfs-kernel-server restart
'

	return $?
}

cd /tmp

#read -n 1 -p "按任意键安装Docker组件. 按 [Ctrl + C] 取消安装."

selectCmd
