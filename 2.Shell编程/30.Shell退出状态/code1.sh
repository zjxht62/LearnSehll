#!/bin/bash

read a
read b

(($a==$b));

echo "退出状态：$?"