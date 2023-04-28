#!/bin/bash
# 捕获退出状态0
trap 'echo "Exit 0 signal detected..."' 0

# 打印信息
echo "This script is used for testing trap command."

#以状态（信号）0 退出此 Shell 脚本
exit 0