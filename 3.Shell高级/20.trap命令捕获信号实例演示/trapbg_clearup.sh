#!/bin/bash

#捕获INT和QUIT信号，如果收到这两个信号，则执行函数my_exit后退出
trap 'my_exit; exit;' SIGINT SIGQUIT

#捕获HUP信号
trap 'echo Going down on a SIGHUP - signal 1, no exiting...; exit' SIGHUP

# 定义count变量
count=0

# 创建临时文件
tmp_file=`mktemp /tmp/file.$$.XXXXXX`

#定义函数my_exit
my_exit()
{
    echo "You hit Ctrl-C/CtrI-\, now exiting..."
    #清除临时文件
    rm -f $tmp_file >& /dev/null
}

#向临时文件写入信息
echo "Do someting..." > $tmp_file

#执行无限while循环
while :
do
    #休眠1秒
    sleep 1
    #将count变量的值加1
    count=$(expr $count + 1)
    #打印count变量的值
    echo $count
done