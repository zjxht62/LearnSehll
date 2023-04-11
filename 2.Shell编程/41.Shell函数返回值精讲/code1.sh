#!/bin/bash

sum=0 #全局变量

function getsum() {
     for (( i = $1; i <=$2; i++ )); do
         ((sum+=i))
     done

     return $? # 返回上一条命令的退出状态
}

read m
read n

if getsum $m $n; then # 调用函数
   echo "The sum is $sum"  #输出全局变量
else
  echo "Error!"
fi