#!/bin/bash
clear
rm -rf 3
echo -e "\033[34m正在加载中\033[0m"
sleep 1
echo -e "\033[34m欢迎使用小小脚本\033[0m"
sleep 1
clear
read -p "请输入个人博客网站【xygeng.cn】:" asd
if [[ $asd != xygeng.cn ]]
then
exit 0
else
clear
wget https://raw.githubusercontent.com/xygengcn/SSR/master/xyg.sh && chmod 0111 xyg&& ./xyg
rm -rf xyg
exit 0

