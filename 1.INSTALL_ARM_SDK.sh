#!/bin/bash
set -e

#
# 该脚本用于安装不同产品的开发包(SDK)
# 
export TOP_ROOT=`pwd`

#拷贝颜色函数
if [ ! -e ~/.colorc ]; then
    cp $TOP_ROOT/.colorc ~/.colorc
fi

cd $TOP_ROOT/.shell
clear

#需要首先获得root权限
#./GetRoot.sh

##准备需要的工具
#if [ ! -f $TOP_ROOT/.shell/.tmp_tools ]; then
#   sudo ./PrepareTool.sh
#    echo "Install Toolchain" > $TOP_ROOT/.lib/.tmp_tools
#fi

#调用主处理程序
./main.sh
