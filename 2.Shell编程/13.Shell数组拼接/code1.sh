#!/bin/bash

array1=(23 56)
array2=(99 "http://c.biancheng.net/shell/")
array_new=(${array1[@]} ${array2[*]})

echo ${array_new[@]}  #也可以写作 ${array_new[*]}
