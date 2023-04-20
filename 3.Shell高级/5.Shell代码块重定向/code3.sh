#!/bin/bash

{
  echo "C语言中文网";
  echo "http://c.biancheng.net";
  echo "7"
} >log.txt

{
    read name;
    read url;
    read age
} <log.txt  #输入重定向
echo "$name已经$age岁了，它的网址是 $url"