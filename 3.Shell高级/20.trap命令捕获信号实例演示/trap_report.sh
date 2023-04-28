#!/bin/bash
#捕获SIGHUP、SIGINT和SIGQUIT信号。如果收到这些信号，将执行函数my_exit后退出
trap 'my_exit $LINENO $BASH_COMMAND; exit' SIGHUP SIGINT SIGQUIT
#函数my_exit
my_exit()
{
    #打印脚本名称，及信号被捕获时所运行的命令和行号
    echo "$(basename $0) caught error on line : $1 command was: $2"
    #将信息记录到系统日志中
    logger -p notice "script: $(basename $0) was terminated: line: $1, command was $2"
    #其他一些清埋命令
}
#执行无限while循环
while :
do
    #休眠1秒
    sleep 1
    #将变量count的值加1
    count=$(expr $count + 1)
    #打印count变量的值
    echo $count
done