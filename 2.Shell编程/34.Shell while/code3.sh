#!/bin/bash

sum=0

echo "请输入您要计算的数字，按Ctrl+D组合键结束读取"
while read n; do
    ((sum += n))
done

echo "The sum is:$sum"