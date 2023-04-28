#!/bin/bash
#捕获信号 SIGINT，然后打印相应信息
trap "echo 'You hit control+C! I am ignoring you.'" SIGINT
#捕获信号 SIGTERM，然后打印相应信息
trap "echo 'You tried to kill me! I am ignoring you.'" SIGTERM
#循环5次
for i in {1..5}; do
    echo "Iteration $i of 5"
    #暂停5秒
    sleep 5
done