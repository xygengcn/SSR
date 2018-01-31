#!/bin/bash
clear
rm -rf xyg
rm -rf 3
##########################################验证#########################################################
function Password (){
ka=`date +"%d%Y"`
TIME=`date +"-%m--%H:%M:%S"`
time_y=`date +%Y`
time_m=`date +%m`
time_d=`date +%d`
time_H=`date +%H`
time_M=`date +%M`


ma=www.xygeng.cn
clear
}
#######################################回到原始主菜单#########################################################
function Main ()
{
clear
wget http://xygeng-1252247588.cossh.myqcloud.com/xyg.sh && chmod 0111 xyg.sh && ./xyg.sh
rm -rf xyg.sh
exit 0
return 0
}
######################SSR操作##################################################
function ssr_tool ()
{
clear
echo "
【1】启动ssr

【2】重启ssr

【3】关闭ssr

【4】查看ssr

【5】编辑密码和端口

【0】退出
"
read -p "输入选项：" input6
case $input6 in
     1)/etc/init.d/shadowsocks start;;
	 2)/etc/init.d/shadowsocks restart;;
	 3)/etc/init.d/shadowsocks stop;;
	 4)/etc/init.d/shadowsocks status;;
	 5)vi /etc/shadowsocks.json;;
	 0)SSR;;
esac
return 0
}
###################################SSR搭建部分##########################################################
function SSR()
{
clear
echo -e "=================================================================================="
echo -e "                                                                                  "
echo -e "     \033[31m【1】西门ssr一键脚本（单端口）\033[0m                                "
echo -e "                                                                                  "
echo -e "     \033[32m【2】多端口ssr一键脚本\033[0m                                        "
echo -e "                                                                                  "
echo -e "     \033[33m【3】综合ssr一键脚本\033[0m"
echo -e "                                                                                  "
echo -e "     \033[34m【4】SSR魔改v2-Bash-Python版\033[0m                                  "
echo -e "                                                                                  "
echo -e "     \033[35m【5】SSR魔改v3一键生成(BBR加速)      \033[0m                         "
echo -e "                                                                                  "
echo -e "     \033[36m【6】一键开SSR端口\033[0m                                            "
echo -e "                                                                                  "
echo -e "     \033[35m【7】op+ssr共存服务器（6.x系统）\033[0m                              "
echo -e "                                                                                  "
echo -e "     \033[34m【8】ssr控制工具\033[0m"
echo -e "                                                                                  "
echo -e "     \033[31m【0】返回主菜单"
echo -e "                                    \033[34mby 庚哥哥工作室\033[0m                "
echo -e "                                  \033[34m现在时间是:\033[0m"$TIME
echo -e "=================================================================================="
echo -e "\033[34m决定你的选择【】\033[0m"
read -p "输入选项：" ssr1
case $ssr1 in
     1)
	 wget http://vpn.ximcx.cn/SSR/SSR && rm -rf taobao && bash SSR && rm -rf SSR
	 ;;
	 2)
	 wget http://service.chuxen.com/SSR && bash SSR && rm -rf SSR
	 ;;
	 3)
	 wget -N --no-check-certificate https://softs.pw/Bash/ssr.sh && chmod +x ssr.sh && bash ssr.sh
	 ;;
	 4)
	 wget -N --no-check-certificate https://raw.githubusercontent.com/xygengcn/SSR/master/ssv2.sh && chmod +x ssv2.sh && bash ssv2.sh
	 ;;
	 5)
	 wget --no-check-certificate https://git.oschina.net/marisn/ssr_v3/raw/master/ssrv3.sh&&chmod +x ssrv3.sh && bash ssrv3.sh && rm -rf ssrv3.sh
	 ;;
	 6)
	 wget https://git.oschina.net/ben123pw/BFW/raw/master/jdk.sh && bash jdk.sh
	 ;;
	 7)
	 wget https://raw.githubusercontent.com/xygengcn/SSR/master/opssr.sh && bash opssr.sh &&rm -rf opssr.sh
	 ;;
	 8)
	 ssr_tool;;
	 0)
	 List
	 ;;
esac
return 0
}
#######################################多功能工具箱######################################################
function tool ()
{
clear
echo -e "=================================================================================="
echo -e "                                                                                  "
echo -e "     \033[31m【1】服务器测速\033[0m"
echo -e "                                                                                  "
echo -e "     \033[32m【2】锐速安装（请先进去升级内核）\033[0m"
echo -e "                                                                                  "
echo -e "     \033[33m【3】卸载锐速\033[0m"
echo -e "                                                                                  "
echo -e "     \033[36m【4】BBR加速\033[0m"
echo -e "                                                                                  "
echo -e "     \033[36m【6】搭键lnmp1.4\033[0m"
echo -e ""
echo -e "     \033[34m【10】宝塔可视化界面\033[0m"
echo -e "                                                                                  "
echo -e "     \033[33m【11】linux图形界面安装\033[0m"
echo -e ""
echo -e "     \033[32m【12】linux的web操作（支持centos5-6）\033[0m"
echo -e "                                                                                  "
echo -e "     \033[31m【0】返回主菜单"
echo -e "                                                                                  "
echo -e "                                    \033[34mby 庚哥哥工作室\033[0m                "
echo -e "                                  \033[34m现在时间是:\033[0m"$TIME
echo -e "=================================================================================="
echo -e "\033[34m决定你的选择【】\033[0m"
read -p "输入选项：" t1
case $t1 in
     1)
     wget https://raw.github.com/sivel/speedtest-cli/master/speedtest.py
     chmod a+rx speedtest.py
     mv speedtest.py /usr/local/bin/speedtest
     chown root:root /usr/local/bin/speedtest
	 speedtest
	 end
	 ;;
	 2)
	 R_S
	 ;;
	 3)
	 chattr -i /serverspeeder/etc/apx* && /serverspeeder/bin/serverSpeeder.sh uninstall -f
	 ;;
	 4)
	 wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh
	 ;;
	 6)
	 wget -c http://soft.vpser.net/lnmp/lnmp1.4beta.tar.gz && rm -rf taobao && tar zxf lnmp1.4beta.tar.gz && cd lnmp1.4 && ./install.sh && rm -rf lnmp1.4beta.tar.gz
	 ;;
	 10)
	 yum install -y wget && wget -O install.sh http://download.bt.cn/install/install.sh && sh install.sh
	 ;;
	 11)
	 yum groups install "MATE Desktop"
	 yum groups install "X Window System"
	 systemctl  set-default  graphical.target
	 echo -e "现在开始重启服务器"
	 reboot
	 ;;
	 12)
	 wget p8os.com/p8os;sh p8os;;
	 0)
	 List
	 ;;
esac
return 0
}
########################################破解流控###########################################################
function control ()
{
clear
echo -e "=================================================================================="
echo -e "                                                                                  "
echo -e "     \033[31m【1】快云流控\033[0m"
echo -e "                                                                                  "
echo -e "     \033[32m【2】康师傅流控【debian 8 64位】\033[0m                              "
echo -e ""
echo -e "     \033[33m【3】VPNS简约版\033[0m"
echo -e ""
echo -e "     \033[31m【0】返回主菜单"
echo -e "                                    \033[34mby 庚哥哥工作室\033[0m                "
echo -e "                                  \033[34m现在时间是:\033[0m"$TIME
echo -e "=================================================================================="
echo -e "\033[34m决定你的选择【】\033[0m"
read -p "输入选项：" c1
case $c1 in
     1)
	 wget --no-check-certificate https://gitee.com/marisn/kuaiyun/raw/master/ky.sh&&chmod +x ky.sh&&bash ky.sh
	 ;;
	 2)
	 wget kftp.opche.com/kangml01-12;chmod 777 kangml01-12;./kangml01-12;;
	 3)
	 wget --no-check-certificate https://git.oschina.net/marisn/vpns/raw/master/vpns.sh&&chmod +x vpns.sh&&bash vpns.sh
	 ;;
	 0)
	 List
	 ;;
esac

return 0
}
####################################主菜单列表#################################################################
function List()
{
clear
echo -e "=================================================================================="
echo -e "                                                                                  "
echo -e "    	                     欢迎使用                                              "
echo -e "                                                                                  "
echo -e "                                                                                  "
echo -e "\033[31m      【1】SSR搭建部分\033[0m"
echo -e "                                                                                  "
echo -e "                                                                                  "
echo -e "\033[32m      【2】多功能工具箱\033[0m"
echo -e "                                                                                  "
echo -e "                                                                                  "
echo -e "\033[33m      【3】破解流控\033[0m"
echo -e "                                                                                  "
echo -e "      【0】退出安装                                                               "
echo -e "                                                                                  "
echo -e "                                                                                  "
echo -e "                                                                                  "
echo -e "                                                                                  "
echo -e "                                    \033[34mby 【www.xygeng.cn】\033[0m           "
echo -e "                                  \033[34m现在时间是:\033[0m"$TIME
echo -e "=================================================================================="
echo -e "\033[34m决定你的选择【】\033[0m"
read -p "输入选项：" input1
case $input1 in
     1)SSR;;
	 2)tool;;
	 3)control;;
	 0)
	 exit;;
esac

end

return 0
}

###########################锐速安装/#换内核教程#######################################################
function R_S(){
echo "*************************************************
	       【1】升级内核（需要重启，重启后再安装锐速）

	       【2】直接安装锐速

	       【0】回到上级菜单
	  *************************************************
			"
	read -p "输入选项：" input2	
	case $input2 in
	     1)
		 echo "*************************************************
		          【1】centos7.x

		          【2】centos6.x

				  【0】返回上一层菜单
				  
			   *************************************************
		     "
		 read -p "输入选项：" input3
		 case $input3 in
		    1)
			wget --no-check-certificate https://blog.asuhu.com/sh/ruisu.sh
			bash ruisu.sh
			;;		
			2)
			rpm -ivh http://wget.ca/Kernel/kernel-firmware-2.6.32-504.3.3.el6.noarch.rpm
			rpm -ivh http://wget.ca/Kernel/kernel-2.6.32-504.3.3.el6.x86_64.rpm --force
			reboot;;
			0)
			R_S
			;;
		 esac;;
	    2)
		 echo "*************************************************
		          【1】vultr

		          【2】阿里云

				  【0】返回上一层菜单
				  
			   *************************************************
		     "
		 read -p "输入选项：" input3
		 case $input3 in
		    1)wget http://vpn.ninian.cc/vpn/jiasu;chmod +x jiasu;./jiasu;;
			2)
		     wget -N --no-check-certificate https://github.com/91yun/serverspeeder/raw/master/serverspeeder.sh && bash serverspeeder.sh;;
			0)
			R_S
			;;
		 esac;;
		0)
		tool;;

	 esac

return 0
}
#####################错误###########################################################################
function mistake(){
echo -e "
	---------------------------------------------------------
	验证失败

	你的验证码可能已经失效了或者错误了

	感谢你的使用，祝你生活愉快！

	请登录博客【www.xygeng.cn】获取最新验证码

    \033[33m     10s后返回上一层主菜单\033[0m

	---------------------------------------------------------
	"
sleep 10
Main
}
###########################结束语#####################################################################3
function end(){
clear
echo -e "\033[34m****************************************************************\033[0m"
read -p "是否返回主菜单【y/n】" input5
if [[ $input5 == y ]]
then
List
else
clear
echo -e "================================================================="
echo -e "                                                                 "
echo -e "                    搭建结果在上面，请往上拉                     "
echo -e "                         失败或成功                              "
echo -e "                                                                 "
echo -e "                       脚本会不时的更新的                        "
echo -e "              验证码也不断更新的，请及时购买新的验证码           "
echo -e "                                                                 "
echo -e "                 所有资源来自【www.xygeng.cn】                   "
echo -e "                                                                 "
echo -e "                         感谢你的使用                            "
echo -e "                                            by【www.xygeng.cn】  "
echo -e "                                   现在时间是:"$TIME
echo -e "================================================================="
exit 0
fi
}
######################################开始执行#######################################################
Password
echo "时间："$TIME
echo -e "
	---------------------------------------------------------
	\033[31m请输入专用验证【www.xygeng.cn】\033[0m
	---------------------------------------------------------
	"
echo -e "\033[32m 验证码：\033[0m"
read mi
##############
if [[ $mi == $ka ]];then
List
clear
sleep 15
end
##############
elif [[ $mi == $ma ]];then
List
clear
rm -rf xyg.sh
sleep 15
end
else
mistake
fi
