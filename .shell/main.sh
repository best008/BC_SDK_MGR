#!/bin/bash
set -e

source ~/.colorc

whiptail --title "百斯特控制-ARM产品SDK管理器(V1.0)" --msgbox \
 "欢迎使用[百斯特控制-ARM产品SDK管理器],本程序用于下载ARM系列产品的SDK开发包,请不要在root账户登录时运行本程序."  15 50 0  --ok-button 知道了


PRODUCT_USR_TYPE=$(whiptail --title "请选择产品型号" \
    --menu "产品列表(上下键选择型号,左右键确定或退出,回车键生效):" 25 60 17 --cancel-button 退出 --ok-button 确定 \
    "0"   "BC_U202_AM335X  通用标准型ARM采集主机" \
    "1"   "BC_U204_S5P6818 运算极速型ARM采集主机" \
    "2"   "BC_U205_NUC972  经济运算型ARM采集主机" \
    "3"   "BC_U411_AM335X  通用标准型ARM人机界面" \
    3>&1 1>&2 2>&3)


if [ "x$PRODUCT_USR_TYPE" = "x0" ]; then
    export PRODUCT_GCC_NAME=BC_ARMGCC_AM335X
    export PRODUCT_ORG_NAME=BC_U202_AM335X
elif [ "x$PRODUCT_USR_TYPE" = "x1" ]; then
    export PRODUCT_GCC_NAME=BC_ARMGCC_S5P6818
    export PRODUCT_ORG_NAME=BC_U204_S5P6818
elif [ "x$PRODUCT_USR_TYPE" = "x2" ]; then
    export PRODUCT_ORG_NAME=BC_U205_NUC972
    export PRODUCT_GCC_NAME=BC_ARMGCC_NUC97X
elif [ "x$PRODUCT_USR_TYPE" = "x3" ]; then
    export PRODUCT_GCC_NAME=BC_ARMGCC_AM335X
    export PRODUCT_ORG_NAME=BC_U411_AM335X
else
    perro "Unkown Product Type: ${PRODUCT_USR_TYPE}"
    exit 1
fi

pinfo "Current Product Type: ${PRODUCT_ORG_NAME}"
export PRODUCT_GCC_GIT_PATH=https://github.com/best008/${PRODUCT_GCC_NAME}.git
export PRODUCT_SDK_GIT_PATH=https://github.com/best008/${PRODUCT_ORG_NAME}_SDK.git

pushd $TOP_ROOT > /dev/null 2>&1
if [ -d ./${PRODUCT_ORG_NAME}_SDK ]; then
    perro "Download ${PRODUCT_ORG_NAME}_SDK Allready Exist!"
    exit 1
fi
 
pinfo "Download ${PRODUCT_ORG_NAME}_SDK [START]"
git clone ${PRODUCT_SDK_GIT_PATH}
if [ $? -ne 0 ]; then
    perro "Download ${PRODUCT_ORG_NAME}_SDK [ERROR]" 
    exit 1
else
    pdone "Download ${PRODUCT_ORG_NAME}_SDK [OK]"
fi
export PRODUCT_SDK_DIR_PATH=${TOP_ROOT}/${PRODUCT_ORG_NAME}_SDK
pushd $PRODUCT_SDK_DIR_PATH > /dev/null 2>&1



#过滤掉编译器的GIT上传，此处是为了代码管理者的方便
pinfo "Install ${PRODUCT_GCC_NAME} [START]"
if [ ! -e ./gitignore ]; then
    echo "0.GCCKIT" > ./.gitignore
fi
mkdir -p ./0.GCCKIT
pushd ./0.GCCKIT > /dev/null 2>&1
git clone ${PRODUCT_GCC_GIT_PATH}
if [ $? -ne 0 ]; then
    perro "Install ${PRODUCT_GCC_NAME} [ERROR]" 
    popd 
    rm -rf ./0.GCCKIT
    exit 1
else
    pdone "Install ${PRODUCT_GCC_NAME} [OK]"
fi
whiptail --title "百斯特控制-ARM产品SDK管理器(V1.0)" --msgbox \
 "恭喜!您已在本机上成功构建了${PRODUCT_ORG_NAME}的SDK开发包,若有相关疑难或需求请及时联系我们."  15 50 0  --ok-button 好的