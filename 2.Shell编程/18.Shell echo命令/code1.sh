#!/bin/bash
name="Shell教程"
url="http://c.biancheng.net/shell/"
echo "读者，你好！"  #直接输出字符串
echo $url  #输出变量
echo "${name}的网址是：${url}"  #双引号包围的字符串中可以解析变量
echo '${name}的网址是：${url}'  #单引号包围的字符串中不能解析变量