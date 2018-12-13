#!/bin/bash
set -e

# 该脚本用于获取root权限

for ((i = 0; i < 5; i++)); do
    PASSWD=$(whiptail --title "百斯特控制-ARM系列产品SDK管理器" \
        --passwordbox "请输入root密码（注意:不能使用root账户执行该程序)" \
        10 60  --ok-button 确定 --cancel-button 退出 3>&1 1>&2 2>&3 )

    if [ $i = "4" ]; then
        whiptail --title "提示!" --msgbox "密码输入错误" 10 40 0
        exit 0
    fi
    #下一次sudo需要输入密码
    sudo -k
    if sudo -lS &> /dev/null << EOF
$PASSWD
EOF
    then
        i=10
    else
        whiptail --title "提示!" --msgbox "无效密码,请输入正确密码!" \
            10 40 0  --ok-button 重试
    fi
done

echo $PASSWD | sudo ls &> /dev/null 2>&1
