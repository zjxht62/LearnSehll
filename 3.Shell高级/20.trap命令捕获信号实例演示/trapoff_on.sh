#!/bin/bash

# 忽略SIGINT和SIGQUIT信号
trap '' SIGINT SIGQUIT

# 打印提示信息
echo "You cannot terminate using ctrl+c or ctrl+\!"

#休眠10秒
sleep 10

#重新捕获SIGINT和SIGQUIT信号。如果捕获到这两个信号，则打印信息后退出
#现在可以中断脚本了
trap 'echo Terminated!; exit' SIGINT SIGQUIT

#打印提示信息
echo "OK! You can now terminate me using those keystrokes"

sleep 10