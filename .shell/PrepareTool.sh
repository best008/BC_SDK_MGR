#!/bin/bash

set -e

#使用颜色打印函数
source ~/.colorc

do_install()
{
	pwarn "Install $1 [START]"
    apt-get -y --no-install-recommends --fix-missing install $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
		pdone "Install $1  [OK]"
	else
		perro "Install $1  [ERROR]"
		exit 1
	fi
}

if ! hash apt-get 2>/dev/null; then
    whiptail --title "提示!" --msgbox "请在类Ubuntu系统上运行该程序" 10 40 0
    exit 1
fi
do_install make

