#!/bin/bash

sum=0
while read n; do
  ((sum+=n))
  echo "this number: $n"
done <nums.txt >log.txt #同时使用输入重定向合输出重定向
echo "sum=$sum"