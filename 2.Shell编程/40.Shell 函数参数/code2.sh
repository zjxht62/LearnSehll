#!/bin/bash

function getsum() {
    local sum=0

    for n in $@
    do
      ((sum+=n))
    done

    echo $sum
    return 0
}

# 调用函数并传递参数，最后将结果赋值给一个变量
total=$(getsum 10 20 55 15)
echo $total


# 也可以将变量省略
echo $(getsum 10 20 55 15)