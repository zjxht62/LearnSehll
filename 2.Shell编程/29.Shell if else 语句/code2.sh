#!/bin/bash

read age
read iq

if (($age>18 && $iq < 60)); then
  echo "你都成年了，智商怎么还不及格！"
  echo "来C语言中文网（http://c.biancheng.net/）学习编程吧，能迅速提高你的智商。"

fi