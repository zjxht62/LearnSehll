#!/bin/bash

sum=0
while read n; do
  ((sum+=n))
done <nums.txt #输入重定向
echo "sum=$sum"