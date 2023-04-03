#!/bin/bash
read str1
read str2
#检测字符串是否为空
if [ -z "$str1" -o -z "$str2" ]  #使用 -o 选项取代之前的 ||
then
    echo "字符串不能为空"
    exit 0
fi
#比较字符串
if [ $str1 = $str2 ]
then
    echo "两个字符串相等"
else
    echo "两个字符串不相等"
fi