#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://blog.linuxeye.com
#
# Notes: OneinStack for CentOS/RadHat 5+ Debian 6+ and Ubuntu 12+
#
# Project home page:
#       http://oneinstack.com
#       https://github.com/lj2007331/oneinstack

if [ -f /etc/redhat-release -o -n "`grep 'Aliyun Linux release' /etc/issue`" ];then
    OS=CentOS
    [ -n "`grep ' 7\.' /etc/redhat-release`" ] && CentOS_RHEL_version=7
    [ -n "`grep ' 6\.' /etc/redhat-release`" -o -n "`grep 'Aliyun Linux release6 15' /etc/issue`" ] && CentOS_RHEL_version=6
    [ -n "`grep ' 5\.' /etc/redhat-release`" -o -n "`grep 'Aliyun Linux release5' /etc/issue`" ] && CentOS_RHEL_version=5
elif [ -n "`grep bian /etc/issue`" ];then
    OS=Debian
    Debian_version=`lsb_release -sr | awk -F. '{print $1}'`
elif [ -n "`grep Ubuntu /etc/issue`" ];then
    OS=Ubuntu
    Ubuntu_version=`lsb_release -sr | awk -F. '{print $1}'`
else
    echo "${CFAILURE}Does not support this OS, Please contact the author! ${CEND}"
    kill -9 $$
fi

if [ `getconf WORD_BIT` == 32 ] && [ `getconf LONG_BIT` == 64 ];then
    OS_BIT=64
    SYS_BIG_FLAG=x64 #jdk
    SYS_BIT_a=x86_64;SYS_BIT_b=x86_64; #mariadb
else
    OS_BIT=32
    SYS_BIG_FLAG=i586
    SYS_BIT_a=x86;SYS_BIT_b=i686;
fi

OS_command(){
    if [ $OS == 'CentOS' ];then
        echo -e $OS_CentOS | bash
    elif [ $OS == 'Debian' -o $OS == 'Ubuntu' ];then
        echo -e $OS_Debian_Ubuntu | bash
    else
        echo "${CFAILURE}Does not support this OS, Please contact the author! ${CEND}" 
        kill -9 $$
    fi
}