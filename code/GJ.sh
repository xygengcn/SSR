#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
clear
echo

echo

#Current folder
cur_dir=`pwd`
# Get public IP address
IP=$(ip addr | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | egrep -v "^192\.168|^172\.1[6-9]\.|^172\.2[0-9]\.|^172\.3[0-2]\.|^10\.|^127\.|^255\.|^0\." | head -n 1)
if [[ "$IP" = "" ]]; then
    IP=$(wget -qO- -t1 -T2 ipv4.icanhazip.com)
fi

# Make sure only root can run our script
function rootness(){
    if [[ $EUID -ne 0 ]]; then
       echo "错误：请使用Root帐号进行安装" 1>&2
       exit 1
    fi
}

# Check OS
function checkos(){
    if [ -f /etc/redhat-release ];then
        OS='CentOS'
    elif [ ! -z "`cat /etc/issue | grep bian`" ];then
        OS='Debian'
    elif [ ! -z "`cat /etc/issue | grep Ubuntu`" ];then
        OS='Ubuntu'
    else
        echo "非常抱歉，一键脚本并不支持当前所在的镜像环境！"
        exit 1
    fi
}
# Get version
function getversion(){
    if [[ -s /etc/redhat-release ]];then
        grep -oE  "[0-9.]+" /etc/redhat-release
    else    
        grep -oE  "[0-9.]+" /etc/issue
    fi    
}

# CentOS version
function centosversion(){
    local code=$1
    local version="`getversion`"
    local main_ver=${version%%.*}
    if [ $main_ver == $code ];then
        return 0
    else
        return 1
    fi        
}

# Disable selinux
function disable_selinux(){
if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    setenforce 0
fi
}

# Pre-installation settings
function pre_install(){
    # Not support CentOS 5
    if centosversion 5; then
        echo "不支持CentOS 5，请更改操作系统CentOS 6 + / 7 + 12 + Debian / Ubuntu并重试。"
        exit 1
    fi
    # 设置SSR的连接密码
    echo
    echo
    echo -e "\033[31m 请设置“远程连接密码”进行下一步安装！\033[0m"
    echo
    read -p "(回车将默认设置“连接密码”为：blog.xygeng.cn):" diosssrpwd
    [ -z "$diosssrpwd" ] && diosssrpwd="blog.xygeng.cn"
    echo
    echo "---------------------------"
    echo -e "\033[36m Ok，“连接密码”已设置为 = $diosssrpwd \033[0m"
    echo "---------------------------"
    echo
    
    echo -e "\033[32m 现在进行SSR的 “端口&加密&协议&混淆”自定义设置！\033[0m"
    echo
    #设置本地端口 
    while true
    do
    read -p "(回车将默认设置“本地端口”为：1081):" diosssrlocalhostport
    [ -z "$diosssrlocalhostport" ] && diosssrlocalhostport="1081"
    expr $diosssrlocalhostport + 0 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ $diosssrlocalhostport -ge 1 ] && [ $diosssrlocalhostport -le 65535 ]; then
    echo
    echo "---------------------------"
    echo -e "\033[36m Ok，“本地端口”已设置为 = $diosssrlocalhostport \033[0m"
    echo "---------------------------"
    echo
    break
        else
            echo -e "\033[31m 错误：请正确设置端口为1-65535之间的数字 \033[0m"
        fi
    else
        echo -e "\033[31m 错误：请正确设置端口为1-65535之间的数字 \033[0m"
        fi
        done
    # 设置SSR加密方法
    read -p "(回车将默认设置“加密方法”为：chacha20):" diosssrjiamifshi
    [ -z "$diosssrjiamifshi" ] && diosssrjiamifshi="chacha20"
    echo
    echo "---------------------------"
    echo -e "\033[36m Ok，“加密方法”已设置为 = $diosssrjiamifshi \033[0m"
    echo "---------------------------"
    echo
    # 设置SSR的连接协议
    read -p "(回车将默认设置“协议”为：auth_sha1_v4):" diosssrxieyi
    [ -z "$diosssrxieyi" ] && diossrxieyi="auth_sha1_v4"
    echo
    echo "---------------------------"
    echo -e "\033[36m Ok，“协议”已设置为 = $diosssrxieyi \033[0m"
    echo "---------------------------"
    echo
    #设置SSR混淆方式
    read -p "(回车将默认设置“混淆方式”为：http_simple):" diosssrhunxiao
    [ -z "$diosssrhunxiao" ] && diosssrhunxiao="http_simple"
    echo
    echo "---------------------------"
    echo -e "\033[36m Ok，“混淆方式”已设置为 = $diosssrhunxiao \033[0m"
    echo "---------------------------"
    echo
    while true
    do
    # 设置SSR端口
    echo -e "\033[31m 设置远程连接端口 [1-65535]: \033[0m"
    read -p "(①端口回车默认设置远程连接端口为: 53 ):" diosssrport1
    [ -z "$diosssrport1" ] && diosssrport1="53"
    expr $diosssrport1 + 0 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ $diosssrport1 -ge 1 ] && [ $diosssrport1 -le 65535 ]; then
                echo "------------------------------------------------------"
                echo -e "\033[31m远程连接①端口已设置为 = $diosssrport1 \033[0m"
                echo "------------------------------------------------------"
            break
        else
        echo -e "\033[31m 错误：请正确设置端口为1-65535之间的数字 \033[0m"
        fi
    else
        echo -e "\033[31m 错误：请正确设置端口为1-65535之间的数字 \033[0m"
        fi
        done
        
    while true
    do
            read -p "(②端口回车默认设置远程连接端口为: 80):" diosssrport2
    [ -z "$diosssrport2" ] && diosssrport2="80"
    expr $diosssrport2 + 0 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ $diosssrport2 -ge 1 ] && [ $diosssrport2 -le 65535 ]; then
                echo "------------------------------------------------------"
                echo -e "\033[31m 远程连接②端口已设置为 = $diosssrport2 \033[0m"
                echo "------------------------------------------------------"
            break
        else
            echo -e "\033[31m 错误：请正确设置端口为1-65535之间的数字 \033[0m"
        fi
    else
        echo -e "\033[31m错误：请正确设置端口为1-65535之间的数字 \033[0m"
        fi
        done
    while true
    do
            read -p "(③端口回车默认设置远程连接端口为: 8080 ):" diosssrport3
    [ -z "$diosssrport3" ] && diosssrport3="8080"
    expr $diosssrport3 + 0 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ $diosssrport3 -ge 1 ] && [ $diosssrport3 -le 65535 ]; then
                echo "------------------------------------------------------"
                echo -e "\033[31m 远程连接③端口已设置为 = $diosssrport3 \033[0m"
                echo "------------------------------------------------------"
            break
        else
            echo -e "\033[31m 错误：请正确设置端口为1-65535之间的数字 \033[0m"
        fi
    else
        echo -e "\033[31m 错误：请正确设置端口为1-65535之间的数字 \033[0m"
        fi
        done
    while true
    do
            read -p "(④端口回车默认设置远程连接端口为: 3128 ):" diosssrport4
    [ -z "$diosssrport4" ] && diosssrport4="3128"
    expr $diosssrport4 + 0 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ $diosssrport4 -ge 1 ] && [ $diosssrport4 -le 65535 ]; then
                echo "------------------------------------------------------"
                echo -e "\033[31m 远程连接④端口已设置为 = $diosssrport4 \033[0m"
                echo "------------------------------------------------------"
            break
        else
            echo -e "\033[31m 错误：请正确设置端口为1-65535之间的数字 \033[0m"
        fi
    else
        echo -e "\033[31m 错误：请正确设置端口为1-65535之间的数字 \033[31m"
        fi
            done
            echo
            echo "------------------------------------------------------"
            echo -e "\033[34m “远程连接密码”已设置为 = $diosssrpwd \033[0m"
            echo -e "\033[34m “本地端口”已设置为 = $diosssrlocalhostport \033[0m"
            echo -e "\033[34m “加密方法”已设置为 = $diosssrjiamifshi \033[0m"
            echo -e "\033[34m “协议”已设置为 = $diosssrxieyi \033[0m"
            echo -e "\033[34m “混淆方式”已设置为 = $diosssrhunxiao \033[0m"
            echo "------------------------------------------------------"
            echo
            echo "------------------------------------------------------"
            echo -e "\033[34m 远程连接①端口已设置为 = $diosssrport1 \033[0m"
            echo -e "\033[34m 远程连接②端口已设置为 = $diosssrport2 \033[0m"
            echo -e "\033[34m 远程连接③端口已设置为 = $diosssrport3 \033[0m"
            echo -e "\033[34m 远程连接④端口已设置为 = $diosssrport4 \033[0m"
            echo "------------------------------------------------------"
            echo

    get_char(){
        SAVEDSTTY=`stty -g`
        stty -echo
        stty cbreak
        dd if=/dev/tty bs=1 count=1 2> /dev/null
        stty -raw
        stty echo
        stty $SAVEDSTTY
    }
    echo
    echo -e "\033[32m 安装前的准备已就绪 按下任意键开始进行安装 \033[0m \033[31m 按下Ctrl+C取消本次安装操作！\033[0m "
    char=`get_char`
    # Install necessary dependencies
    if [ "$OS" == 'CentOS' ]; then
        yum install -y wget unzip openssl-devel gcc swig python python-devel python-setuptools autoconf libtool libevent git ntpdate
        yum install -y m2crypto automake make curl curl-devel zlib-devel perl perl-devel cpio expat-devel gettext-devel
    else
        apt-get -y update
        apt-get -y install python python-dev python-pip python-m2crypto curl wget unzip gcc swig automake make perl cpio build-essential git ntpdate
    fi
    cd $cur_dir
}
# Download files
function download_files(){
    # Download libsodium file
    if ! wget --no-check-certificate -O libsodium-1.0.10.tar.gz https://raw.githubusercontent.com/xygengcn/SSR/master/code/libsodium-1.0.10.tar.gz; then
        echo "错误：抱歉，libsodium文件下载失败！"
        exit 1
    fi
    # Download ShadowsocksR file
    # if ! wget --no-check-certificate -O manyuser.zip https://raw.githubusercontent.com/xygengcn/SSR/master/code/shadowsocks-manyuser.zip; then
        # echo "错误：抱歉，shadowsocksr文件下载失败！"
        # exit 1
    # fi
    # Download ShadowsocksR chkconfig file
    if [ "$OS" == 'CentOS' ]; then
        if ! wget --no-check-certificate https://raw.githubusercontent.com/xygengcn/SSR/master/code/ShadowsocksR -O /etc/init.d/shadowsocks; then
            echo "错误：抱歉，shadowsocksr chkconfig文件下载失败！"
            exit 1
        fi
    else
        if ! wget --no-check-certificate https://raw.githubusercontent.com/xygengcn/SSR/master/code/ShadowsocksR-debian -O /etc/init.d/shadowsocks; then
            echo "错误：抱歉，ShadowsocksR-debian文件下载失败！"
            exit 1
        fi
    fi
}

# firewall set
function firewall_set(){
    echo "请稍候......正在设置防火墙"
    if centosversion 6; then
        /etc/init.d/iptables status > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            iptables -L -n | grep '${sdiosssrport1}' | grep 'ACCEPT' > /dev/null 2>&1
            iptables -L -n | grep '${sdiosssrport2}' | grep 'ACCEPT' > /dev/null 2>&1
            iptables -L -n | grep '${sdiosssrport3}' | grep 'ACCEPT' > /dev/null 2>&1
            iptables -L -n | grep '${sdiosssrport4}' | grep 'ACCEPT' > /dev/null 2>&1
            if [ $? -ne 0 ]; then
                iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${diosssrport1} -j ACCEPT
                iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${diosssrport1} -j ACCEPT
                iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${diosssrport2} -j ACCEPT
                iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${diosssrport2} -j ACCEPT
                iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${diosssrport3} -j ACCEPT
                iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${diosssrport3} -j ACCEPT
                iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${diosssrport4} -j ACCEPT
                iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${diosssrport4} -j ACCEPT
                /etc/init.d/iptables save
                /etc/init.d/iptables restart
            else
                echo "端口 ${diosssrport1}；${diosssrport2}；${diosssrport3}；${diosssrport4} 已创建成功"
            fi
        else
            echo "警告：防火墙似乎没有安装请手动安装防火墙"
        fi
    elif centosversion 7; then
        systemctl status firewalld > /dev/null 2>&1
        if [ $? -eq 0 ];then
                firewall-cmd --permanent --zone=public --add-port=${diosssrport1}/tcp
                firewall-cmd --permanent --zone=public --add-port=${diosssrport1}/udp
                firewall-cmd --permanent --zone=public --add-port=${diosssrport2}/tcp
                firewall-cmd --permanent --zone=public --add-port=${diosssrport2}/udp
                firewall-cmd --permanent --zone=public --add-port=${diosssrport3}/tcp
                firewall-cmd --permanent --zone=public --add-port=${diosssrport3}/udp
                firewall-cmd --permanent --zone=public --add-port=${diosssrport4}/tcp
                firewall-cmd --permanent --zone=public --add-port=${diosssrport4}/udp
            firewall-cmd --reload
        else
            echo "防火墙好像没有启动，正在尝试启动！"
            systemctl start firewalld
            if [ $? -eq 0 ];then
                firewall-cmd --permanent --zone=public --add-port=${diosssrport1}/tcp
                firewall-cmd --permanent --zone=public --add-port=${diosssrport1}/udp
                firewall-cmd --permanent --zone=public --add-port=${diosssrport2}/tcp
                firewall-cmd --permanent --zone=public --add-port=${diosssrport2}/udp
                firewall-cmd --permanent --zone=public --add-port=${diosssrport3}/tcp
                firewall-cmd --permanent --zone=public --add-port=${diosssrport3}/udp
                firewall-cmd --permanent --zone=public --add-port=${diosssrport4}/tcp
                firewall-cmd --permanent --zone=public --add-port=${diosssrport4}/udp
                firewall-cmd --reload
            else
                echo "警告：防火墙启动失败，请手动启用端口${diosssrport1}；${diosssrport2}；${diosssrport3}；${diosssrport4}"
            fi
        fi
    fi
    echo "firewall set completed..."
}

# Config ShadowsocksR
function config_shadowsocks(){
    cat > /etc/shadowsocks.json<<-EOF
{
    "server": "0.0.0.0",
    "server_ipv6": "::",
    "local_address":"127.0.0.1",
    "local_port":${diosssrlocalhostport},
    "port_password":{
        "${diosssrport1}":"${diosssrpwd}",
        "${diosssrport2}":"${diosssrpwd}",
        "${diosssrport3}":"${diosssrpwd}",
        "${diosssrport4}":"${diosssrpwd}"
    },
    "timeout":300,
    "method":"${diosssrjiamifshi}",
    "protocol": "${diosssrxieyi}_compatible",
    "protocol_param": "",
    "obfs": "${diosssrhunxiao}_compatible",
    "obfs_param": "",
    "redirect": "",
    "dns_ipv6": false,
    "fast_open": false,
    "workers": 1
}
EOF
}
# Install ShadowsocksR
function install_ss(){
    # Install libsodium
    tar zxf libsodium-1.0.10.tar.gz
    cd $cur_dir/libsodium-1.0.10
    ./configure && make && make install
    echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf
    ldconfig
    # Install ShadowsocksR
    cd $cur_dir
    # unzip -q manyuser.zip
    # mv shadowsocks-manyuser/shadowsocks /usr/local/
	git clone https://github.com/xygengcn/shadowsocksr-1.git /usr/local/shadowsocks
    if [ -f /usr/local/shadowsocks/server.py ]; then
        chmod +x /etc/init.d/shadowsocks
        # Add run on system start up
        if [ "$OS" == 'CentOS' ]; then
            chkconfig --add shadowsocks
            chkconfig shadowsocks on
        else
            update-rc.d -f shadowsocks defaults
        fi
        # Run ShadowsocksR in the background
        /etc/init.d/shadowsocks start
        clear
        echo
        echo -e "\033[36m 恭喜你！我们已为你完成了所有的安装，以下是连接信息！\033[0m"
        echo -e "服务器IP地址: \033[31m ${IP} \033[0m"
        echo -e "远程端口: \033[32m ${diosssrport1}；${diosssrport2}；${diosssrport3}；${diosssrport4} \033[0m"
        echo -e "密码: \033[32m ${diosssrpwd} \033[0m"
        echo -e "本地IP地址: \033[32m 127.0.0.1 \033[0m"
        echo -e "本地端口: \033[32m ${diosssrlocalhostport} \033[0m"
        echo -e "认证协议: \033[36m ${diosssrxieyi} \033[0m"
        echo -e "混淆方式: \033[36m ${diosssrhunxiao} \033[0m"
        echo -e "加密方法: \033[36m ${diosssrjiamifshi} \033[0m"
        echo
        echo
        echo
    else
        echo -e "\033[35m ShadowsocksR 安装失败！\033[0m"
        install_cleanup
        exit 1
    fi
}

#改成北京时间
function check_datetime(){
	rm -rf /etc/localtime
	ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	ntpdate 210.72.145.44
}

# Install cleanup
function install_cleanup(){
    cd $cur_dir
    rm -f manyuser.zip
    rm -rf shadowsocks-manyuser
    rm -f libsodium-1.0.10.tar.gz
    rm -rf libsodium-1.0.10
    rm -rf GJ
    rm -rf SSR

}
# Uninstall ShadowsocksR
function uninstall_shadowsocks(){
    printf "你真的要卸载ShadowsocksR？(Y/n) "
    printf "\n"
    read -p "(回车将默认为: n):" answer
    if [ -z $answer ]; then
        answer="n"
    fi
    if [ "$answer" = "y" ]; then
        /etc/init.d/shadowsocks status > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            /etc/init.d/shadowsocks stop
        fi
        checkos
        if [ "$OS" == 'CentOS' ]; then
            chkconfig --del shadowsocks
        else
            update-rc.d -f shadowsocks remove
        fi
        rm -f /etc/shadowsocks.json
        rm -f /etc/init.d/shadowsocks
        rm -rf /usr/local/shadowsocks
        echo "ShadowsocksR 已成功卸载！"
    else
        echo "卸载请求已取消！"
    fi
}
# Install ShadowsocksR
function install_shadowsocks(){
    checkos
    rootness
    disable_selinux
    pre_install
    download_files
    config_shadowsocks
    install_ss
    if [ "$OS" == 'CentOS' ]; then
        firewall_set > /dev/null 2>&1
    fi
	check_datetime
    install_cleanup
	
}

# Initialization step
action=$1
[ -z $1 ] && action=install
case "$action" in
install)
    install_shadowsocks
    ;;
uninstall)
    uninstall_shadowsocks
    ;;
*)
    echo "参数错误 [${action} ]"
    echo "Usage: `basename $0` {install|uninstall}"
    ;;
esac
