## erlang 环境

#### 基础环境安装
	yum -y install perl-devel.x86_64 jq-devel
	yum -y install make gcc gcc-c++ kernel-devel m4 ncurses-devel openssl-devel 

#### Opt安装
	wget  http://erlang.org/download/otp_src_21.3.tar.gz
	tar -zxvf otp_src_21.3.tar.gz
	cd otp_src_21.3
	mkdir -p /opt/erlang
#### 配置编译安装
	./configure --prefix=/opt/erlang 
	make && make install
#### 添加到Path变量
	ln -s /opt/erlang/bin/erl    /usr/local/bin/erl
	echo 'pathmunge /opt/erlang/bin' > /etc/profile.d/optPath.sh

	chmod +x /etc/profile.d/optPath.sh

	source /etc/profile

#### rebar3 编译安装
	mkdir -p /opt/rebar
	cd /opt/rebar
	git clone https://github.com/erlang/rebar3.git
	cd ./rebar3
	./bootstrap
	chmod +x /opt/rebar3/rebar3

#### 持久化
	rebar3 local install




## 构建 EMQx Plugin
		

