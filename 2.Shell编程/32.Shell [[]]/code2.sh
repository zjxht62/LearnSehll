#!/bin/bash

read tel
if [[ $tel =~ ^1[0-9]{10}$ ]]; then
  echo "你输入的是合法手机号"
else
  echo "你输入的不是合法手机号"
fi