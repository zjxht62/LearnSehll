#!/bin/bash
#打印信息
echo "Adjust the size of your window now."
#捕获SIGWINCH信号
trap "echo Window size changed." SIGWINCH
#定义变量
COUNT=0
#while循环30次
while [ $COUNT -lt 30 ]; do
    #将COUNT变量的值加1
    COUNT=$(($COUNT + 1))
    #休眠1秒
    sleep 1
done