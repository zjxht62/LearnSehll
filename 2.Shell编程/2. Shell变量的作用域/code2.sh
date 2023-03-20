#!/bin/bash
# 定义函数
function func() {
    local a=99
}
# 调用函数
func
# 输出函数内部的变量
echo $a