#!/bin/bash

exec 6<&0 #先将0号文件描述符(也就是标准输入）保存起来
exec <nums.txt # 输入重定向

sum=0
while read n; do
  ((sum += n))
done

echo "sum=$sum"

exec 0<&6 6<&-  #恢复输入重定向，并关闭文件描述符6

read -p "请输入名字、网址和年龄：" name url age
echo "$name已经$age岁了，它的网址是 $url"
