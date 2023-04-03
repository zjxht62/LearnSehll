#!/bin/bash

read age

if test $age -le 2; then
  echo "婴儿"
elif [ $age -ge 3 ] && test $age -le 8; then
  echo "幼儿"
elif [ $age -ge 9 ] && [ $age -le 17 ]; then
  echo "少年"
elif [ $age -ge 18 ] && [ $age -le 25 ]; then
      echo "成年"
elif test $age -ge 26 && test $age -le 40; then
    echo "青年"
elif test $age -ge 41 && [ $age -le 60 ]; then
    echo "中年"
else
    echo "老年"
fi


