#!/bin/bash

arr=(23 56 99 "http://c.biancheng.net/shell")
unset arr[1]
echo ${arr[@]}

unset arr
echo ${arr[*]}