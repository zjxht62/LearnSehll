#!/bin/bash

read str1
read str2

if [[ -z $str1 ]] || [[ -z $str2 ]]; then
  echo "字符串不能为空"
elif [[ $str1 < $str2 ]]; then
  echo "str1 < str2"
else
  echo "str1 >= str2"
fi